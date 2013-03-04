require 'faraday_middleware'
require 'grim_repo/client/page_links_parser'
require 'grim_repo/client/status_handler'
require 'grim_repo/uris'

module GrimRepo
  class Client
    # Creates a new authenticated client, using basic authentication.
    #
    # @param username [String] a GitHub username
    # @param password [String] a GitHub password
    def initialize(username, password)
      @username, @password = username, password
    end

    # Runs a GET request on the client's connection.
    #
    # @param uri [URI] the URI to fetch
    # @yieldparam response [Faraday::Response] the reponse
    # @return [Array, Hash] the parsed JSON response
    def get(uri)
      path = [uri.path, uri.query].compact.join('?')
      response = connection.get(path)
      yield response if block_given?
      response.body
    end

    # Fetches the user the client is authenticated as.
    #
    # @return [User]
    def user
      data = get(URIs::AuthenticatedUser)
      User.new(self, data)
    end

    # Fetches a user by login name.
    #
    # @param login [String] a GitHub username
    # @return [User, nil]
    def users(login)
      data = get(URIs::User[login])
      User.new(self, data)
    rescue NotFound
      nil
    end

    private

    attr_reader :username, :password

    def connection
      @connection ||= Faraday.new(url: 'https://api.github.com') do |faraday|
        faraday.basic_auth(username, password)

        faraday.use FaradayMiddleware::ParseJson
        faraday.use PageLinksParser
        faraday.use StatusHandler

        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
