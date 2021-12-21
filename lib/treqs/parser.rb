# frozen_string_literal: true

require 'json'
require 'toml'

# Turns a input file into a hash
module Parser
  class Error < StandardError; end

  # A config file like:
  # ```
  # url = "example.com"
  # method = "GET"
  # ```
  # becomes:
  # ```
  # { 'url' => 'example.com', 'method' => 'GET" }
  # ```
  #
  # @param [String] the path to the request config file
  # @raise [Parser::Error] if file extension is not supported
  # @return [Hash]
  def call(filepath)
    file = File.new(filepath)
    extension = File.extname(file)

    case extension
    when '.toml'
      TOML.load_file(filepath)
    when '.json'
      JSON.parse(file.read)
    else
      raise Error, "Extension #{ext} not supported"
    end
  end

  module_function :call
end
