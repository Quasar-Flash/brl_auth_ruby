# frozen_string_literal: true

module BRL
  module Auth
    class Connection < Flash::Integration::Connection
      ACCEPT       = "application/json"
      CONTENT_TYPE = "application/x-www-form-urlencoded"

      def initialize(request_class: Faraday, base_url: BRL::Auth::BASE_URL)
        super(request_class: request_class, base_url: base_url)
      end

      def default_headers
        {
          "Accept": "application/json",
          "Authorization": authorization_string,
          "Content-Type": CONTENT_TYPE
        }
      end

      protected
        def authorization_string
          handshake = BRL.configuration.handshake.strip
          secret_key = BRL.configuration.secret_key.strip
          auth_string = ::Base64.strict_encode64("#{handshake}:#{secret_key}")

          "basic #{auth_string}"
        end
    end
  end
end
