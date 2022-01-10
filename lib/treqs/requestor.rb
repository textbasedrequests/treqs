# frozen_string_literal: true

require 'faraday'

# Module to make HTTP calls
module Requestor
  class Error < StandardError; end

  # Fires a request based on a [Config] object
  # @param [Config]
  # @return [String]
  def call(config)
    conn = Faraday.new(
      url: config.url,
      headers: config.headers,
      params: config.params
    )

    method = config.method.downcase
    json   = config.body.to_json

    conn.send(method) { |req| req.body = json }
        .body
  end

  module_function :call
end
