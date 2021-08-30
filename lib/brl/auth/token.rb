# frozen_string_literal: true

module BRL
  module Auth
    class Token
      attr_reader :access_token, :created_at, :expires_in, :refresh_token, :scope, :token_type

      def initialize(access_token: nil, created_at: Time.now.zone, expires_in: nil, refresh_token: nil, scope: nil, token_type: nil)
        @access_token  = access_token
        @created_at    = created_at
        @expires_in    = expires_in
        @refresh_token = refresh_token
        @scope         = scope
        @token_type    = token_type
      end
    end
  end
end
