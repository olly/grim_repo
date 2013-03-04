require 'grim_repo/paginated_collection'
require 'grim_repo/repository'

module GrimRepo
  class Repositories < PaginatedCollection
    # @param client [Client] the client to fetch the repositories.
    # @param user [User] the user whose repositories to fetch.
    def initialize(client, user)
      @user = user

      super(client)
    end

    # @return [User]
    attr_reader :user

    private
    def initial_uri
      URIs::UserRepositories[user.login]
    end

    def build(data)
      GrimRepo::Repository.new(client, data)
    end
  end
end
