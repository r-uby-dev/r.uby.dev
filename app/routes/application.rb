# frozen_string_literal: true

module Raven::Routes
  class Application < Roda
    include Raven::Agents

    plugin :render,
      views: File.join(Raven.root, "app", "views"),
      cache: false,
      check_template_mtime: true
    plugin :public, root: File.join(Raven.root, "public")
    plugin :sessions, secret: ENV["SESSION_SECRET"] || "change me" * 24
    plugin :route_csrf, require_request_specific_tokens: false, check_header: true
    plugin :all_verbs
    plugin :agent, agents: [{class: Robert, scope: :session}]

    route do |r|
      r.public
      r.agent!

      r.root do
        view("index")
      end

      r.on "resume" do
        r.get(true) { resume! }
        r.root { resume! }
        r.get("index.html") { resume! }
      end
    end

    ##
    # My resume
    def resume!
      response["content-type"] = "text/html"
      view("resume", engine: "md", layout: "resume")
    end

    ##
    # Inlines a file (typically an SVG) from public/images
    # as an <object> with a data: URI. The bytes stay in the
    # HTML (no extra request), but the object renders as its
    # own document so SVG CSS animations run and the artwork
    # isn't re-styled by the page.
    def svg!(name)
      root = File.expand_path("../../public/images/", __dir__)
      path = File.expand_path(File.join(root, name))
      return unless path.start_with?(root + File::SEPARATOR) and File.file?(path)
      encoded = strict_encode64(File.read(path))
      %(<object
         type="image/svg+xml"
         data="data:image/svg+xml;base64,#{encoded}"
         aria-hidden="true">
         </object>)
    end

    ##
    # Inlines a JavaScript file as a <script> in the page, so
    # it loads without an extra network round-trip.
    # @param [String] name
    #  The JS file name within public/assets/js
    # @return [String]
    #  A script tag with the file contents inlined
    def js!(name)
      root = File.expand_path("../../public/assets/js/", __dir__)
      path = File.expand_path(File.join(root, name))
      unless path.start_with?(root + File::SEPARATOR) and File.file?(path)
        raise ArgumentError, "js file not found: #{name}"
      end
      %(<script>#{File.read(path)}</script>)
    end
    include Base64
  end
end