# frozen_string_literal: true

require_relative "spec_helper"

RSpec.describe "sessionful agent" do
  def agent = Raven::Agents::Robert
  def app = Raven::Routes::Application

  # Fetch the CSRF token embedded in the homepage meta tag.
  def csrf_token
    get "/"
    last_response.body[/name="_csrf" content="([^"]+)"/, 1]
  end

  it "serves the homepage" do
    get "/"
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("r.uby.dev")
  end

  it "serves the resume" do
    get "/resume"
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Resume")
  end

  describe "POST /agents/robert" do
    it "creates an agent and binds it to the session" do
      token = csrf_token
      expect {
        post "/agents/robert", {}, {"HTTP_X_CSRF_TOKEN" => token}
      }.to change(agent, :count).by(1)
      expect(last_response.status).to eq(200)
      body = JSON.parse(last_response.body)
      expect(body["ok"]).to eq(true)
      expect(body["id"]).to eq(agent.last.id)
      expect(last_request.session["agent_id:robert"]).to eq(agent.last.id)
    end

    it "rejects a request without a CSRF token" do
      expect {
        post "/agents/robert"
      }.not_to change(agent, :count)
      expect(last_response.status).to eq(403)
    end
  end

  describe "GET /agents/robert" do
    it "responds with a server-sent event stream" do
      get "/agents/robert", q: "hello"
      expect(last_response.status).to eq(200)
      expect(last_response["Content-Type"]).to eq("text/event-stream")
    end
  end

  describe "DELETE /agents/robert" do
    it "destroys the bound agent and clears the session" do
      token = csrf_token
      post "/agents/robert", {}, {"HTTP_X_CSRF_TOKEN" => token}
      agent_id = agent.last.id

      expect {
        delete "/agents/robert", {}, {"HTTP_X_CSRF_TOKEN" => token}
      }.to change(agent, :count).by(-1)
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)["ok"]).to eq(true)
      expect(agent.exists?(agent_id)).to eq(false)
      expect(last_request.session["agent_id:robert"]).to be_nil
    end
  end
end
