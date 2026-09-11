# frozen_string_literal: true

module Raven::Resolvers
  ##
  # The {Raven::Resolvers::Session Session} resolver stores one
  # agent per visitor session, and records the visitor's client
  # IP on each generated agent.
  class Session < LLM::Roda::Resolver::Session
    ##
    # Create an agent and bind it to this visitor's anonymous session.
    # @param [Class(LLM::Agent)] klass
    # @return [LLM::Agent]
    def create(klass)
      klass.create!(owner: request.ip)
        .tap { roda.session[key!(klass)] = it.id }
    end
  end
end
