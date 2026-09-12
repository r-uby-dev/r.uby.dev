#!/usr/bin/env -S bundle exec falcon host
# frozen_string_literal: true

##
# Falcon service definition for r.uby.dev.
#
# Run with `bundle exec falcon host` (or `service rubydev reload`), which
# starts an async-service Controller that:
#
#   * binds a single shared listener in the parent process,
#   * forks N worker processes that all accept on that shared listener, and
#   * on SIGHUP performs a blue-green restart: it forks fresh workers, waits
#     for them to become ready, then gracefully drains the old ones.
#
# Each worker loads the app fresh from config.ru, so a SIGHUP picks up newly
# deployed code without dropping any in-flight requests.
#
# NOTE: Do not enable `preload` here. Preloading loads the application into
# the parent process, which would make new workers inherit *stale* in-memory
# code on reload. We deliberately keep the parent thin and let each worker
# boot the app from disk.

require "falcon/environment/rack"

hostname = "r.uby.dev"
bind = ENV.fetch("RUBYDEV_BIND", "127.0.0.1")
port = ENV.fetch("RUBYDEV_PORT", "9292")
count = Integer(ENV.fetch("RUBYDEV_WORKERS", "1"))

service(hostname) do
  include Falcon::Environment::Rack
  count(count)
  preload(false)
  endpoint do
    Async::HTTP::Endpoint.parse("http://#{bind}:#{port}").with(
      protocol: Async::HTTP::Protocol::HTTP1,
      # Let a second instance bind the same port. A deploy that brings new
      # gems, a new falcon.rb or new environment cannot be picked up by a
      # running process, so `service rubydev restart` starts a second
      # instance alongside the first, waits until it is listening, and only
      # then stops the old one - the port is never without a server. Every
      # instance has to ask for this, since a socket only shares a port
      # with others that asked for the same; the first deploy after this
      # was added therefore still needs one plain stop and start.
      reuse_port: true
    )
  end
end
