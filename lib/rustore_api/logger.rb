# frozen_string_literal: true

require 'logger'

module RustoreApi
  class Logger < ::Logger
    def self.logger
      @logger ||= begin
        logger = new $stdout
        logger.level = Logger::WARN
        logger
      end
    end
  end
end
