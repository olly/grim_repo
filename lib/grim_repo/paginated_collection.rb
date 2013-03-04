module GrimRepo
  class PaginatedCollection < Enumerator
    # @param client [Client] the client used for API requests.
    def initialize(client)
      @client = client

      @next_uri = initial_uri

      super(&iterator)
    end

    # @return [Client]
    attr_reader :client

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

    def initial_uri
      raise NotImplementedError, 'subclasses must implement #initial_uri'
    end

    def build(data)
      raise NotImplementedError, 'subclasses must implement #build'
    end
  end
end
