# frozen_string_literal: true

require 'rails_helper'
require 'extended_hash'

EXPECTED_COMPLETE_RESPONSE_STRUCTURE = {
  'key_stock_data' => {
    'P/E Ratio (TTM)' => {
      'value' => nil,
      'metadata' => {
        'type' => nil,
        'value' => nil
      }
    },
    'EPS (TTM)' => {
      'prefix' => nil,
      'value' => nil
    },
    'Market Cap' => {
      'prefix' => nil,
      'value' => nil
    },
    'Shares Outstanding' => {
      'value' => nil
    },
    'Public Float' => {
      'value' => nil
    },
    'Yield' => {
      'value' => nil,
      'metadata' => {
        'type' => nil,
        'value' => nil
      }
    },
    'Latest Dividend' => {
      'prefix' => nil,
      'value' => nil,
      'metadata' => {
        'type' => nil,
        'value' => nil
      }
    },
    'Ex-Dividend Date' => {
      'value' => nil
    }
  },
  'short_interest_data' => {
    'date' => nil,
    'Shares Sold Short' => {
      'value' => nil
    },
    'Change from Last' => {
      'value' => nil
    },
    'Percent of Float' => {
      'value' => nil
    }
  }
}.freeze

RSpec.describe StockDataController, type: :controller do
  let(:symbol) {'MSFT'}
  let(:params) {{ symbol: symbol }}
  let(:response_hash) {JSON.parse(response.body)}

  before do
    get(:show, params: params)
  end

  it 'returns a successful JSON response' do
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
  end

  context 'when testing with an already-downloaded website source' do
    # TODO
  end

  context 'when testing with a live website source' do
    it 'returns a response with no blank values for a stock that should have no blank values' do
      # TODO: set symbol for this assertion
      expect(response_hash.contains_same_keys_deep(EXPECTED_COMPLETE_RESPONSE_STRUCTURE)).to be true
      expect(response_hash.contains_no_blank_values_deep).to be true
    end
  end
end
