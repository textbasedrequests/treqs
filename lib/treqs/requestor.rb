# frozen_string_literal: true

require 'faraday'

# Module to make HTTP calls
module Requestor
  class Error < StandardError; end

  # Given a config file, fires a request
  # @param [Config]
  def call(config)
    conn = Faraday.new(
      url: config.url,
      headers: config.headers,
      params: config.params
    )

    case config.method
    when 'GET'
      conn.get.body
    when 'POST'
      res = conn.post() do |req|
        req.body = config.body.to_json
      end
      res.body
    end
  end

  module_function :call
end
