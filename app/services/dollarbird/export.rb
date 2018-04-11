module Dollarbird
  class Export
    attr_reader :username,
      :password

    def initialize(username, password)
      @username = username
      @password = password
    end

    def initiate
      auth_token = Account.new(
        username,
        password
      ).authentication_token

      ::HttpClient.new(
        ENV.fetch('CSV_EXPORT_URL')
      ).post do |req|
        req['Accept'] = "application/json"
        req['Authorization'] = auth_token

        req
      end

    rescue StandardError => e
      e.message
    end
  end
end
