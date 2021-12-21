# frozen_string_literal: true

# Checks structure of the input hash
module Checker
  class RequiredKeysError < StandardError; end
  class ExtraKeysError < StandardError; end

  REQUIRED_KEYS = %w[url method].to_set
  EXTRA_KEYS = %w[headers body].to_set

  # @param [Hash]
  # @raise [Checker::RequiredKeysError]
  # @raise [Checker::ExtraKeysError]
  # @return [Hash]
  def call(config_hash)
    config_hash
      .keys
      .to_set
      .then { |keys_set| validate_required(keys_set) }
      .then { |keys_set| validate_allowed(keys_set) }

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

  module_function :call
end
