# frozen_string_literal: true

require 'faraday'

# Module to make HTTP calls
module Requestor
  class Error < StandardError; end

  # Fires a request based on a Config object
  # @param [Config]
  def call(config)
    conn = Faraday.new(
      url: config.url,
      headers: config.headers,
      params: config.params
    )

    res = conn.send(config.method.downcase) do |req|
      req.body = config.body.to_json
    end
    res.body
  end

  module_function :call
end
