module FaviconExtractor
  class ExtractsFaviconsFromHtml
    class << self
      def extract(html, url)
        @url = url
        html.scan(/<link.*?icon.*?>/).flatten.map do |str|
          str.match(/href="(.*?)"/).captures.first
        end
          .map { |str| handle_relative_paths(str) }
          .append(default_favicon)
      end

      private

      DEFAULT_FAVICON_PATH = "/favicon.ico"

      def handle_relative_paths(str)
        if str.start_with?("/")
          uri = URI(@url)
          uri.path = str
          uri.to_s
        else
          str
        end
      end

      def default_favicon
        uri = URI(@url)
        uri.path = DEFAULT_FAVICON_PATH
        uri.to_s
      end
    end
  end
end
