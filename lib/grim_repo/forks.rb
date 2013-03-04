require 'grim_repo/paginated_collection'
require 'grim_repo/repository'

module GrimRepo
  class Forks < PaginatedCollection
    def initialize(client, repository)
      @repository = repository
      super(client)
    end

    # @return [Repository]
    attr_reader :repository

    private
    def initial_uri
      URIs::RepositoryForks[repository.full_name]
    end

    def build(data)
      GrimRepo::Repository.new(client, data)
    end
  end
end
