# frozen_string_literal: true

# Checks structure of the input hash
module Checker
  class RequiredKeysError < StandardError; end

  class ExtraKeysError < StandardError; end

  class UnsupportedHTTPMethod < StandardError; end

  REQUIRED_KEYS = %w[url method].to_set
  EXTRA_KEYS = %w[headers body params].to_set
  HTTP_METHODS_ALLOWED = %w[delete get head post put trace patch].to_set

  # @param [Hash]
  # @raise [Checker::RequiredKeysError]
  # @raise [Checker::ExtraKeysError]
  # @raise [Checker::UnsupportedHTTPMethod]
  # @return [Hash]
  def call(config_hash)
    config_hash
      .keys
      .to_set
      .then { |keys_set| validate_required(keys_set) }
      .then { |keys_set| validate_allowed(keys_set) }

    config_hash
      .then { |request_hash| validate_http_methods_allowed(request_hash) }

    config_hash
  end

  # @param [Set]
  # @raise [Checker::RequiredKeysError]
  # @return [Set]
  def self.validate_required(input_keys)
    minimum = REQUIRED_KEYS.all?(input_keys)
    error_msg = "Missing #{REQUIRED_KEYS} in the config file"
    raise RequiredKeysError, error_msg unless minimum

    input_keys
  end

  # @param [Set]
  # @raise [Checker::ExtraKeysError]
  # @return [Set]
  def self.validate_allowed(input_keys)
    possible_keys = REQUIRED_KEYS + EXTRA_KEYS
    has_diff = input_keys.difference(possible_keys).count.positive?
    error_msg = "Can only use #{possible_keys}"
    raise ExtraKeysError, error_msg if has_diff

    input_keys
  end

  # @param [Hash]
  # @raise [Checker::ExtraKeysError]
  # @return [Hash]
  def self.validate_http_methods_allowed(request_hash)
    valid_method = HTTP_METHODS_ALLOWED.include?(request_hash["method"].downcase)
    error_msg = "Can only use one of #{HTTP_METHODS_ALLOWED.to_a} as http method"
    raise UnsupportedHTTPMethod, error_msg if not valid_method

    request_hash
  end

  module_function :call
end
