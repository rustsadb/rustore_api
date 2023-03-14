# frozen_string_literal: true

module RustoreApi
  module Endpoints
    def authorize!
      timestamp = (DateTime.now - 1.second).strftime('%Y-%m-%dT%H:%M:%S%:z')
      options = {
        body: {
          companyId: company_id,
          timestamp: timestamp,
          signature: sign(timestamp)
        }
      }
      response = handle_response(post('public/auth', options))
      @auth_token = response[:body][:jwe]
      @token_expired_at = DateTime.now + response[:body][:ttl].seconds

      response
    end

    def payment_data(subscription_token)
      authorize if token_expired_or_nil?

      options = {
        headers: {
          'Public-Token' => @auth_token
        }
      }

      handle_response(get("/public/purchases/#{subscription_token}", options))
    end

    def subscription_by_invoice_id(invoice_id)
      authorize if token_expired_or_nil?

      options = {
        headers: {
          'Public-Token' => @auth_token
        }
      }

      handle_response(get("/public/subscriptions/#{invoice_id}", options))
    end

    def subscription_by_purchase_token(package_name, subscription_id, purchase_token)
      authorize if token_expired_or_nil?

      options = {
        headers: {
          'Public-Token' => @auth_token
        }
      }

      handle_response(
        get("/public/v2/subscription/#{package_name}/#{subscription_id}/#{purchase_token}", options)
      )
    end

    def subscription_state(invoice_id)
      authorize if token_expired_or_nil?

      options = {
        headers: {
          'Public-Token' => @auth_token
        }
      }

      handle_response(get("/public/subscriptions/#{invoice_id}/state", options))
    end

    private

    def sign(timestamp)
      payload = "#{company_id}#{timestamp}"
      pkey = OpenSSL::PKey::RSA.new(private_key)
      sign = pkey.sign(OpenSSL::Digest.new('SHA512'), payload)

      Base64.strict_encode64(sign)
    end

    def handle_response(response)
      ::Oj.load(response, symbol_keys: true)
    end

    def token_expired_or_nil?
      @auth_token.nil? || @token_expired_at.nil? || DateTime.now > @token_expired_at
    end
  end
end
