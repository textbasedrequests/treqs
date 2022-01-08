# frozen_string_literal: true

require_relative '../lib/treqs/checker'

RSpec.describe Checker do
  describe '.call' do
    context 'when input is good' do
      let(:input) { { 'url' => 'url', 'method' => 'GET' } }

      it 'does not raise an error' do
        expect { Checker.call(input) }.not_to raise_error
      end
    end

    context 'when input is missing a required key' do
      let(:input) { { 'url' => 'https://example.com' } }

      it 'raises an error' do
        expect { Checker.call(input) }.to raise_error(Checker::RequiredKeysError)
      end
    end

    context 'when input has extra keys' do
      let(:input) { { 'url' => 'url', 'method' => 'GET', 'extra' => 'key' } }

      it 'raises an error' do
        expect { Checker.call(input) }.to raise_error(Checker::ExtraKeysError)
      end
    end

    context 'when input has an invalid HTTP method' do
      let(:input) { { 'url' => 'url', 'method' => 'super' } }

      it 'raises an error' do
        expect { Checker.call(input) }.to raise_error(Checker::UnsupportedHTTPMethod)
      end
    end
  end
end
