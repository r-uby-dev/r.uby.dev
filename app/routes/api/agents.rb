# frozen_string_literal: true

class Raven::Routes::API
  class Agents < self
    route do |r|
      r.post(true) do
        check_csrf!
        create_agent!(session["agent_id"])
      end
    end

    private

    ##
    # Create an agent, yo.
    # @param [String, nil] id
    #  An existing agent id, if any
    # @return [Hash]
    def create_agent!(id)
      if agent = Raven::Agents::Robert.find_by(id:)
        {ok: true, id: agent.id}
      else
        agent = Raven::Agents::Robert.create!(owner: request.ip)
        session["agent_id"] = agent.id
        {ok: true, id: agent.id}
      end
    end
  end
end