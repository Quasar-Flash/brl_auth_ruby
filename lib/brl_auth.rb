# frozen_string_literal: true

require "base64"
require "flash_integration"
require "i18n"
require "json"

require "brl/auth/version"

require "brl/auth/connection"
require "brl/auth/token"
require "brl/auth/token_service"
require "brl/auth/authenticated_resource"
require "brl/auth/authenticated_connection"

require "brl/auth/base_error"
require "brl/auth/authentication_error"
require "brl/auth/bad_request_error"
require "brl/auth/invalid_credentials_error"
require "brl/auth/server_error"
require "brl/auth/unexpected_error"

I18n.load_path += Dir[File.join(__dir__, "locales", "**/*.yml")]
I18n.reload! if I18n.backend.initialized?

module BRL
  BASE_URL = "https://hom.api.acesso.hmra.com.br/autorizacao/token"

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end
  end

  def self.configure
    self.configuration ||= Configuration.new

    yield(configuration)
  end

  class Configuration
    attr_writer :auth_base_url, :handshake, :secret_key

    def auth_base_url
      @auth_base_url ||= ENV["BRL_AUTH_BASE_URL"]
    end

    def handshake
      @handshake ||= ENV["BRL_HANDSHAKE"]
    end

    def secret_key
      @secret_key ||= ENV["BRL_SECRET_KEY"]
    end
  end

  module Auth
    BASE_URL         = "https://hom.api.acesso.hmra.com.br"
    TOKEN_ENDPOINT   = "autorizacao/token"
    TOKEN_EXPIRATION = 86_400
  end
end
