# frozen_string_literal: true

require 'sidekiq-scheduler'

class ReportExporter
  include Sidekiq::Worker

  def perform
    ::Dollarbird::Export.new(
      ENV.fetch('IDENTITY'),
      ENV.fetch('PASSWORD')
    ).initiate
  end
end
