require 'grim_repo/forks'
require 'grim_repo/language'
require 'grim_repo/uris'

module GrimRepo
  class Repository
    # Creates a new repository with data from the API.
    #
    # @param client [Client] the client that fetched this user.
    # @param data [Hash] parsed JSON representation from the API.
    def initialize(client, data)
      @client = client

      @name = data['name']
      @full_name = data['full_name']
      @forks_count = data['forks_count']
    end

    # @return [String]
    attr_reader :name

    # @return [String]
    attr_reader :full_name

    def forks
      Forks.new(client, self, count: forks_count)
    end

    # The programming languages used in the repository.
    #
    # @note The languages are cached in an instance variable, subsequent calls
    #   will result in the same results.
    # @return [Array<Language>]
    def languages
      @languages ||= client.get(URIs::RepositoryLanguages[self.full_name]).map do |name, bytes|
        Language.new(name, bytes)
      end
    end

    private

    attr_reader :client, :forks_count
  end
end
