module GrimRepo
  # @api private
  module URIs
    UserRepositories = ->(login) { URI.parse("https://api.github.com/users/#{login}/repos") }
    RepositoryForks = ->(full_repository_name) { URI.parse("https://api.github.com/repos/#{full_repository_name}/forks") }
    RepositoryLanguages = ->(full_repository_name) { URI.parse("https://api.github.com/repos/#{full_repository_name}/languages") }

    AuthenticatedUser = URI.parse('https://api.github.com/user')
    User = ->(login) { URI.parse("https://api.github.com/users/#{login}") }
  end
end
