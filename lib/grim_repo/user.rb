module GrimRepo
  class User
    # Creates a new user with data from the API.
    #
    # @param client [Client] the client that fetched this user.
    # @param data [Hash] parsed JSON representation from the API.
    def initialize(client, data)
      @client = client

      @api_url = parse_uri(data['url'])
      @avatar_url = parse_uri(data['avatar_url'])
      @bio = data['bio']
      @blog = parse_uri(data['blog'])
      @company = data['company']
      @created_at = Time.iso8601(data['created_at'])
      @email = data['email']
      @gravatar_id = data['gravatar_id']
      @hireable = data['hireable']
      @id = data['id']
      @location = data['location']
      @login = data['login']
      @name = data['name']
      @url = parse_uri(data['html_url'])
    end

    # The URL for the API representaton of the user.
    # @return [URI]
    attr_reader :api_url

    # @return [URI]
    attr_reader :avatar_url

    # @return [String, nil]
    attr_reader :bio

    # @return [URI, nil]
    attr_reader :blog

    # @return [String, nil]
    attr_reader :company

    # @return [Time]
    attr_reader :created_at

    # @return [String, nil]
    attr_reader :email

    # @return [String]
    attr_reader :gravatar_id

    # @return [Fixnum]
    attr_reader :id

    # @return [String, nil]
    attr_reader :location

    # @return [String]
    attr_reader :login

    # @return [String, nil]
    attr_reader :name

    # The URL for the user's GitHub page.
    # @return [URI, nil]
    attr_reader :url

    # Whether the user has checked 'Available for Hire' in their profile.
    # @return [Boolean]
    def hireable?
      @hireable
    end

    private

    attr_reader :client

    def parse_uri(uri)
      return if uri.nil?
      URI.parse(uri)
    end
  end
end
