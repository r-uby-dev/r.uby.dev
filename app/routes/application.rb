# frozen_string_literal: true

module Raven::Routes
  class Application < Roda
    plugin :json
    plugin :sse
    plugin :render, views: File.join(__dir__, "..", "views")
    plugin :public, root: File.expand_path("../../public", __dir__)
    plugin :all_verbs
    plugin :sessions, secret: ENV["SESSION_SECRET"] || "change me" * 24
    plugin :route_csrf, require_request_specific_tokens: false, check_header: true
    plugin :send_file

    route do |r|
      r.public

      r.on "assets/js" do
        r.get(/(.+)/) do |file|
          root = File.expand_path(File.join(Raven.root, "app", "assets", "js"))
          path = File.expand_path(File.join(root, file))
          next unless path.start_with?(root + File::SEPARATOR) && File.file?(path)
          send_file path
        end
      end

      r.root do
        view("index")
      end

      r.on "resume" do
        r.get(true) { resume! }
        r.root { resume! }
        r.get("index.html") { resume! }
      end

      r.on "api" do
        r.run Raven::Routes::API
      end
    end

    ##
    # My resume :)
    def resume!
      response["content-type"] = "text/html"
      view("resume", engine: "md", layout: "resume")
    end

    ##
    # Inlines a file (typically an SVG) from public/images
    # as raw content, so no extra image request is needed.
    # Paths are resolved against the public/images dir and
    # must stay within it.
    def inline!(name)
      root = File.expand_path("../../public/images/", __dir__)
      path = File.expand_path(File.join(root, name))
      return unless path.start_with?(root + File::SEPARATOR) and File.file?(path)
      File.read(path)
    end
  end
end