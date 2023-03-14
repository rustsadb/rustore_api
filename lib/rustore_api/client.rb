# frozen_string_literal: true

module RustoreApi
  class Client
    include Connection
    include Request
    include Endpoints
    attr_accessor(*Config::ATTRIBUTES)

    def initialize(options = {})
      RustoreApi::Config::ATTRIBUTES.each do |key|
        send("#{key}=", options[key] || RustoreApi.config.send(key))
      end
      @logger ||= RustoreApi::Logger.logger
    end

    class << self
      def configure
        block_given? ? yield(Config) : Config
      end

      def config
        Config
      end
    end
  end
end
