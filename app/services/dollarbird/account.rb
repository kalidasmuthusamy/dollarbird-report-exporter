# frozen_string_literal: true

module Dollarbird
  class Account
    attr_reader :username,
                :password

    def initialize(username, password)
      @username = username
      @password = password
    end

    def authentication_token
      sign_in_response = ::HttpClient.new(
        ENV.fetch('SIGN_IN_URL')
      ).post do |req|
        req['Accept'] = 'application/json'
        req['Content-Type'] = 'application/json;charset=UTF-8'

        req.body = authentication_payload.to_json
        req
      end

      parsed_authentication_response = JSON.parse(
        sign_in_response.body
      )

      parsed_authentication_response['token']
    rescue StandardError
      ''
    end

    private

    def authentication_payload
      {
        'identity' => username,
        'password' => password
      }
    end
  end
end
