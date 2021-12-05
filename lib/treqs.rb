# frozen_string_literal: true

require 'net/http'
require 'toml'
require_relative 'treqs/version'

# Some doc here :)
module Treqs
  class Error < StandardError; end

  def call(filepath)
    config = TOML.load_file(filepath)

    url = URI(config['url'])
    method = config['method']
    request(method, url)
  end

  def request(method, url, body = nil)
    case method
    when 'GET'
      Net::HTTP.get(url)
    when 'POST'
      Net::HTTP.post(url, body)
    end
  end

  module_function :call, :request
end
