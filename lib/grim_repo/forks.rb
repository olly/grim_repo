require 'grim_repo/paginated_collection'
require 'grim_repo/repository'

module GrimRepo
  class Forks < PaginatedCollection
    # @param client [Client] the client to fetch the repositories.
    # @param repository [Repository] the repositories whose forks to fetch.
    # @param count [Fixnum] the number of forks.
    def initialize(client, repository, count: nil)
      @repository = repository
      @cached_count = count
      super(client)
    end

    # @return [Repository]
    attr_reader :repository

    # @private
    UNDEFINED = Object.new.freeze

    # Returns the cached number of forks if no argument or block is provided.
    #
    # Otherwise uses the Enumerable implementation. Will calculate the count
    # (by fetching all forks) if a cached count isn't provided.
    #
    # @see http://ruby-doc.org/core-2.0/Enumerable.html#method-i-count Enumerable#count
    # @return [Fixnum]
    def count(item = UNDEFINED, &block)
      if item != UNDEFINED
        super(item)
      elsif block_given?
        super(&block)
      elsif cached_count
        cached_count
      else
        super()
      end
    end

    private
    attr_reader :cached_count

    def initial_uri
      URIs::RepositoryForks[repository.full_name]
    end

    def build(data)
      GrimRepo::Repository.new(client, data)
    end
  end
end
