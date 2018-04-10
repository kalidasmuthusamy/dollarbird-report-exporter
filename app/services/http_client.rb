# frozen_string_literal: true
require 'net/http'
# Service to make HTTP requests
class HttpClient
  attr_reader :endpoint,
    :options

  def initialize(endpoint, options = {})
    @endpoint = endpoint
    @options = options
  end

  def post
    request_obj = block_given? ? yield(post_request_obj) : post_request_obj
    http_obj.request(request_obj)
  end

  private

  def http_obj
    http = Net::HTTP.new(full_uri.host, full_uri.port)
    http.read_timeout = options[:timeout] || 5000
    http.set_debug_output $stdout # Print the http debug.
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true if full_uri.scheme == 'https'
    http
  end

  def full_uri
    @full_uri ||= URI.parse(endpoint)
  end

  def post_request_obj
    Net::HTTP::Post.new(full_uri.path, {})
  end
end
