module GrimRepo
  class Repository
    # Creates a new repository with data from the API.
    #
    # @param client [Client] the client that fetched this user.
    # @param data [Hash] parsed JSON representation from the API.
    def initialize(client, data)
      @client = client

      @name = data['name']
    end

    # @return [String]
    attr_reader :name

    private

    attr_reader :client
  end
end
