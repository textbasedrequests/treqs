# frozen_string_literal: true

# Checks structure of the input hash
module Checker
  class RequiredKeysError < StandardError; end
  class ExtraKeysError < StandardError; end
  class UnsupportedHTTPMethod < StandardError; end

  REQUIRED_KEYS = %w[url method].to_set
  EXTRA_KEYS = %w[headers body params].to_set
  HTTP_METHODS = %w[delete get head post put trace patch].to_set

  # @param [Hash]
  # @raise [Checker::RequiredKeysError]
  # @raise [Checker::ExtraKeysError]
  # @raise [Checker::UnsupportedHTTPMethod]
  # @return [Hash]
  def call(config_hash)
    config_hash
      .then { |hash| validate_structure(hash) }
      .then { |hash| validate_values(hash) }
  end

  # @param [Hash]
  # @raise [Checker::RequiredKeysError]
  # @raise [Checker::ExtraKeysError]
  # @return [Hash]
  def self.validate_structure(config_hash)
    config_hash
      .then { |hash| validate_required_keys(hash) }
      .then { |hash| validate_extra_keys(hash) }
  end

  # @param [Hash]
  # @raise [Checker::ExtraKeysError]
  # @return [Hash]
  def self.validate_values(config_hash)
    config_hash
      .then { |hash| validate_http_methods(hash) }
  end

  # @param [Hash]
  # @raise [Checker::RequiredKeysError]
  # @return [Hash]
  def self.validate_required_keys(config_hash)
    input_keys = config_hash.keys.to_set
    minimum = REQUIRED_KEYS.all?(input_keys)
    error_msg = "Missing #{REQUIRED_KEYS} in the config file"
    raise RequiredKeysError, error_msg unless minimum

    config_hash
  end

  # @param [Hash]
  # @raise [Checker::ExtraKeysError]
  # @return [Hash]
  def self.validate_extra_keys(config_hash)
    input_keys = config_hash.keys.to_set
    possible_keys = REQUIRED_KEYS + EXTRA_KEYS
    has_diff = input_keys.difference(possible_keys).count.positive?
    error_msg = "Can only use #{possible_keys}"
    raise ExtraKeysError, error_msg if has_diff

    config_hash
  end

  # @param [Hash]
  # @raise [Checker::UnsupportedHTTPMethod]
  # @return [Hash]
  def self.validate_http_methods(config_hash)
    is_valid_method = HTTP_METHODS.include?(config_hash['method'].downcase)
    error_msg = "Can only use one of #{HTTP_METHODS.to_a} as HTTP method"
    raise UnsupportedHTTPMethod, error_msg unless is_valid_method

    config_hash
  end

  module_function :call
end
