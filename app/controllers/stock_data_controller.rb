# frozen_string_literal: true

class StockDataController < ActionController::Base

  def show
    doc = NokogiriUtil::get_html("https://quotes.wsj.com/#{params[:symbol]}")

    render json: {
      ResponseConstants::Keys::KEY_STOCK_DATA_KEY => Parser::parse_key_stock_data(doc),
      ResponseConstants::Keys::SHORT_INTEREST_DATA_KEY => Parser::parse_short_interest_data(doc)
    }
  end

end
