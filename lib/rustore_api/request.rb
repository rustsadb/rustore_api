# frozen_string_literal: true

module RustoreApi
  module Request
    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    private

    #
    # @param [Symbol] method - Faraday HTTP method.
    # @param [String] path - URL to send.
    # @param [Hash] options -  :endpoint, :body keys will configure the request.
    #   The rest will be converted to query params for GET/DELETE, or jsonified for POST/PUT.
    #
    # @return [Object] - the Faraday::Response#body.
    #
    def request(method, path, options)
      options = options.dup
      root = options.delete(:endpoint) || endpoint
      path = [root, path].join('/')
      response = connection.send(method) do |request|
        request.headers.merge(options.delete(:headers)) if options[:headers].present?

        case method
        when :get
          request.url(path, options)
        when :post
          request.path = path
          if options.key?(:body)
            request.body = options.delete(:body).to_json
          elsif !options.empty?
            request.body = options.to_json
          end
        end
        request.options.merge!(options.delete(:request)) if options.key?(:request)
      end
      response.body
    end
  end
end
