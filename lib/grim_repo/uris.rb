module GrimRepo
  # @api private
  module URIs
    UserRepositories = ->(login) { URI.parse("https://api.github.com/users/#{login}/repos") }

    AuthenticatedUser = URI.parse('https://api.github.com/user')
    User = ->(login) { URI.parse("https://api.github.com/users/#{login}") }
  end
end
