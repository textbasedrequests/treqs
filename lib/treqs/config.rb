# frozen_string_literal: true

# Class containing the request information
class Config
  attr_reader :method, :url, :headers, :body, :params

  # @param [Hash]
  def initialize(config_hash)
    @method = config_hash['method']
    @url = URI(config_hash['url'])
    @headers = config_hash['headers']
    @body = config_hash['body']
    @params = config_hash['params']
  end
end
