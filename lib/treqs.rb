# frozen_string_literal: true

require_relative 'treqs/version'
require_relative 'treqs/parser'
require_relative 'treqs/checker'
require_relative 'treqs/config'
require_relative 'treqs/requestor'

# Main interface
module Treqs
  def call(filepath)
    filepath
      .then { |fpath|  Parser.call(fpath) }
      .then { |hash|   Checker.call(hash) }
      .then { |hash|   Config.new(hash) }
      .then { |config| Requestor.call(config) }
  end

  module_function :call
end
