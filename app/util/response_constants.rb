# frozen_string_literal: true

module ResponseConstants

  module Keys
    KEY_STOCK_DATA_KEY = 'key_stock_data'.freeze
    SHORT_INTEREST_DATA_KEY = 'short_interest_data'.freeze
    
    PE_RATIO_KEY = 'P/E Ratio (TTM)'.freeze
    EPS_KEY = 'EPS (TTM)'.freeze
    MARKET_CAP_KEY = 'Market Cap'.freeze
    SHARES_OUTSTANDING_KEY = 'Shares Outstanding'.freeze
    PUBLIC_FLOAT_KEY = 'Public Float'.freeze
    YIELD_KEY = 'Yield'.freeze
    LATEST_DIVIDEND_KEY = 'Latest Dividend'.freeze
    EX_DIVIDENT_DATE_KEY = 'Ex-Dividend Date'.freeze
    
    DATE_KEY = 'date'.freeze
    SHARES_SOLD_SHORT_KEY = 'Shares Sold Short'.freeze
    CHANGE_FROM_LAST_KEY = 'Change from Last'.freeze
    PERCENT_OF_FLOAT_KEY = 'Percent of Float'.freeze

    VALUE = 'value'.freeze
    TYPE = 'type'.freeze
    PREFIX = 'prefix'.freeze
    METADATA = 'metadata'.freeze
    DATE = 'date'.freeze
    START_DATE = 'start'.freeze
    END_DATE = 'end'.freeze
  end

  module ValueTypes
    TEXT = 'text'.freeze
    DATE = 'date'.freeze
    DATE_RANGE = 'date_range'.freeze
    DATES = 'dates'.freeze
  end

end
