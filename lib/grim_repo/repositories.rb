require 'grim_repo/repository'

module GrimRepo
  class Repositories < Enumerator
    # @param client [Client] the client to fetch the repositories.
    # @param user [User] the user whose repositories to fetch.
    def initialize(client, user)
      @client = client
      @user = user

      @next_uri = URIs::UserRepositories[user.login]

      super(&iterator)
    end

    # @return [Client]
    attr_reader :client

    # @return [User]
    attr_reader :user

    private

    attr_accessor :next_uri

    def fetch(uri)
      client.get(uri) do |response|
        self.next_uri = response.env[:links]['next']
      end
    end

    def iterator
      ->(yielder) do
        while next_uri
          fetch(next_uri).each do |data|
            yielder << build(data)
          end
        end
      end
    end

    def build(data)
      GrimRepo::Repository.new(client, data)
    end
  end

end
