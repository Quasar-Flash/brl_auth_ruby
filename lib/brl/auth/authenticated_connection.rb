# frozen_string_literal: true

module BRL
  module Auth
    class AuthenticatedConnection < Connection
      COOKIE_CACHE_KEY = "BRL_AUTH_COOKIE_CACHE_KEY"
      CONTENT_TYPE     = "application/json"

      def initialize(token_service: BRL::Auth::TokenService.new,
                      cache: defined?(Rails) ? Rails.cache : nil,
                      request_class: Faraday,
                      base_url: BRL::BASE_URL)
        super(request_class:, base_url:)
        @token_service = token_service
        @cache = cache
      end

      def default_headers
        {
          "Accept": CONTENT_TYPE,
          "Authorization": (@cache ? cached_token : auth_token),
          "Content-Type": CONTENT_TYPE
        }
      end

      private
        def auth_token
          token = @token_service.retrieve

          "Bearer #{token.access_token}"
        end

        def cached_token
          @cache.fetch(COOKIE_CACHE_KEY, expires_in: BRL::Auth::TOKEN_EXPIRATION) { auth_token }
        end
    end
  end
end
