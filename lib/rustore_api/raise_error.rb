# frozen_string_literal: true

module RustoreApi
  module Response
    class RaiseError < ::Faraday::Middleware
      def on_complete(env)
        case env[:status]
        when (400...600).freeze
          raise RustoreApi::Errors::Fault, response_values(env)
        end
      end

      def response_values(env)
        {
          status: env.status,
          headers: env.response_headers,
          body: env.body
        }
      end
    end
  end
end
