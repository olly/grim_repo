require 'faraday'
require 'link_header'

class GrimRepo::Client
  # Faraday Middleware which parses the Link header.
  # @api private
  class PageLinksParser < Faraday::Response::Middleware
    def on_complete(env)
      header = env[:response_headers]['Link']
      links = LinkHeader.parse(header).to_a
      env[:links] = links.each.with_object({}) do |(uri, attributes), links|
        uri = URI.parse(uri)
        _, relationship = attributes.detect {|(key, value)| key == 'rel'}

        links[relationship] = uri
      end
    end
  end
end
