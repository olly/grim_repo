require 'faraday_middleware'

module GrimRepo
  class Client
    def initialize(username, password)
      @username, @password = username, password
    end

    def user
      data = get('/user')
      User.new(data)
    end

    private

    attr_reader :username, :password

    def connection
      @connection ||= Faraday.new(url: 'https://api.github.com') do |faraday|
        faraday.basic_auth(username, password)

        faraday.use FaradayMiddleware::ParseJson

        faraday.adapter Faraday.default_adapter
      end
    end

    def get(path)
      response = connection.get(path)
      response.body
    end
  end
end
