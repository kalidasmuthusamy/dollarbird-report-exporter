# frozen_string_literal: true

class ApplicationController < ActionController::API
  def export_report
    initiation_response = Dollarbird::Export.new(
      ENV.fetch('IDENTITY'),
      ENV.fetch('PASSWORD')
    ).initiate

    if initiation_response.is_a?(::Net::HTTPAccepted)
      head :no_content
    else
      render json: initiation_response, status: :unprocessable_entity
    end
  end
end
