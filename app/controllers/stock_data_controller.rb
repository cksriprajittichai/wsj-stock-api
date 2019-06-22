# frozen_string_literal: true

class StockDataController < ActionController::Base

  def show
    doc = NokogiriUtil::get_html("https://quotes.wsj.com/#{params[:symbol]}")

    render json: {
      'key_stock_data': Parser::parse_key_stock_data(doc),
      'short_interest_data': Parser::parse_short_interest_data(doc)
    }
  end

end
