# frozen_string_literal: true

module BRL
  module Auth
    class TokenService
      def initialize(connection: Connection.new)
        @connection = connection
      end

      def retrieve
        res = @connection.post(url: BRL::Auth::TOKEN_ENDPOINT, body: BRL::Auth::TokenService.login_body)

        return parse_response(res.body) if res.status == 200

        raise BRL::Auth::BadRequestError if res.status == 400
        raise BRL::Auth::InvalidCredentialsError if res.status == 401
        raise BRL::Auth::ServerError if res.status == 500
        raise BRL::Auth::UnexpectedError
      end

      private
        def self.login_body
          URI.encode_www_form({ grant_type: "client_credentials", scope: "refresh_token" })
        end

        def parse_response(res)
          res = JSON.parse(res)

          BRL::Auth::Token.new(
            access_token:  res["access_token"],
            created_at:    Time.now.utc,
            expires_in:    res["expires_in"],
            refresh_token: res["refresh_token"],
            scope:         res["scope"],
            token_type:    res["token_type"]
          )
        end
    end
  end
end
