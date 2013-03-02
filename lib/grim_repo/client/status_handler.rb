require 'faraday'

class GrimRepo::Client
  # @abstract
  class APIError < StandardError; end

  # Raised when a 404 response is returned.
  class NotFound < APIError; end

  # Faraday Middleware which raises exceptions for particular status codes.
  # @api private
  class StatusHandler < Faraday::Response::Middleware

    # Mapping of status codes to exception classes.
    ERRORS = {
      404 => ::GrimRepo::Client::NotFound
    }

    def on_complete(env)
      error = ERRORS[env[:status]]
      raise error if error
    end
  end
end
