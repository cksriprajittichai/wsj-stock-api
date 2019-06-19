require 'nokogiri'
require 'open-uri'

class StockDataController < ActionController::Base

  def show
    doc = Nokogiri::HTML(open("https://quotes.wsj.com/#{params[:symbol]}"))
    data_divs = doc.css('div.cr_data_points:nth-child(1) > ul:nth-child(3) div.cr_data_field')

    result = Hash.new

    data_divs.each do |div|
      key = div.at_css('h5.data_lbl')
      value = div.at_css('span.data_data')

      data = Hash.new
      
      value.children.each do |child|
        next if node_is_blank? child

        if child.text?
          data['value'] = child.content.strip
          next
        end

        if child.element?
          if child.name == 'sup'
            data['prefix'] = child.content.strip
            next
          end

          if child['class'] == 'data_meta'
            data['metadata'] = child.content.strip
            next
          end
        end
      end

      result[key.content.strip] = data
    end
    
    render json: result
  end


  private


  def node_is_blank? node
    (node.text? && node.content.strip.empty?) || (node.element? && node.name == 'br')
  end

  def node_is_present? node
    !node_is_blank? node
  end

end
