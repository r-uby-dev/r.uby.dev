# frozen_string_literal: true

module Raven
  require "bundler/setup"
  require "active_record"
  require "roda"
  require "roda/plugins/sse"
  require "llm"
  require "llm/active_record"
  require "paranoia"
  require "json"
  require "erb"
  require "yaml"
  require "base64"
  require "digest"
  require "test-cmd"

  Routes = Module.new
  Agents = Module.new

  ##
  # @return [String]
  def self.env
    ENV["RACK_ENV"] || "development"
  end

  ##
  # @return [String]
  def self.root
    File.realpath File.join(__dir__, "..")
  end

  ##
  # @return [String]
  def self.appdir
    File.join root, "app"
  end

  ##
  # @return [String]
  def self.version
    @version ||= File.read(File.join(root, ".version")).strip
  end

  ##
  # Cache busting for an asset served out of public/. The version is a
  # digest of the file itself rather than the commit, so a rebuilt asset
  # gets a new URL even when it has not been committed yet.
  #
  # @param [String] path
  #  A path relative to public/
  # @return [String]
  def self.asset_version(path)
    file = File.join(root, "public", path)
    return version unless File.file?(file)
    stamp = File.mtime(file).to_f
    @asset_versions ||= {}
    cached = @asset_versions[path]
    return cached[1] if cached && cached[0] == stamp
    @asset_versions[path] = [stamp, Digest::SHA1.file(file).hexdigest[0, 10]]
    @asset_versions[path][1]
  end

  ##
  # Establish database connection
  raw    = ERB.new(File.read(File.join(__dir__, "database.yml"))).result
  config = YAML.safe_load(raw, aliases: true)
  conn   = config.fetch(Raven.env)
  ActiveRecord::Base.establish_connection(conn)

  ##
  # Boot the rest of the application: load the agent plugin first
  # (it registers `:agent`, `LLM::Roda::Resolver` and the stream
  # alias), then load every app file sorted by path. That ordering
  # puts app/resolvers/... and app/agents/... before app/routes/...
  # so both exist before application.rb calls
  # `plugin :agent, agents: [{class: Robert, resolver: ...}]`.
  require "roda-llm"
  Dir[File.join(appdir, "resolvers", "**", "*.rb")].sort.each { require(it) }
  Dir[File.join(appdir, "**", "*.rb")].sort.each { require(it) }
end
