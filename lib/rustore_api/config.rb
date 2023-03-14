# frozen_string_literal: true

module RustoreApi
  module Config
    module_function

    ATTRIBUTES = %i[
      auth_token
      token_expired_at
      endpoint
      company_id
      private_key_path
      private_key
      proxy
      user_agent
      ca_path
      ca_file
      logger
      timeout
      open_timeout
      lang
      units
    ].freeze

    attr_accessor(*Config::ATTRIBUTES)

    def reset
      self.endpoint = 'https://pay-backapi.rustore.ru'
      self.company_id = nil
      self.private_key_path = nil
      self.auth_token = nil
      self.token_expired_at = nil
      self.private_key = nil
      self.user_agent = "RustoreApi Ruby Client/#{RustoreApi::VERSION}"
      self.ca_path = nil
      self.ca_file = nil
      self.proxy = nil
      self.logger = nil
      self.timeout = nil
      self.open_timeout = nil
      self.lang = nil
      self.units = nil
    end
  end

  class << self
    def configure
      block_given? ? yield(Config) : Config
    end

    def config
      Config
    end

    def private_key=(key)
      private_key = <<~KEY
        -----BEGIN RSA PRIVATE KEY-----
        #{key}
        -----END RSA PRIVATE KEY-----
      KEY
    end
  end
end

RustoreApi::Config.reset
