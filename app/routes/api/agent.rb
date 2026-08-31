# frozen_string_literal: true

class Raven::Routes::API
  class Agent < self
    route do |r|
      r.get(true) do
        r.sse do |sse|
          talk(r, sse)
        end
      end

      r.delete(true) do
        check_csrf!
        Robert.find_by(id: agent_id)&.destroy
        session.delete("agent_id")
        {ok: true}
      end
    end

    ##
    # @return [String, nil]
    def agent_id
      session["agent_id"]
    end

    ##
    # Talk to an agent
    # @return [void]
    def talk(r, sse)
      q      = r.params["q"].to_s
      stream = Robert::Stream.new(sse).tap(&:hello)
      agent  = Robert.find(agent_id)
      res    = agent.talk(q, stream:)
      stream.done(res:)
    rescue ActiveRecord::RecordNotFound
      stream.error(message: "agent unavailable")
    rescue
      stream.error(message: "internal server error")
    end
    include Raven::Agents
  end
end
