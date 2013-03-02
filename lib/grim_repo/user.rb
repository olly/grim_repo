module GrimRepo
  class User
    def initialize(data)
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

    attr_reader :api_url, :avatar_url, :bio, :blog, :company, :created_at,
                :email, :gravatar_id, :id, :location, :login, :name, :url

    def hireable?
      @hireable
    end

    private
    def parse_uri(uri)
      return if uri.nil?
      URI.parse(uri)
    end
  end
end
