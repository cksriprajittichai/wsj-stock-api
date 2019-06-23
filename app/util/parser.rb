# frozen_string_literal: true

module Parser

  DATE_REGEX = /\d{2}\/\d{2}\/\d{2}/.freeze

  def self.parse_key_stock_data(doc)
    data_divs = doc.css('div.cr_data_points:nth-child(1) > ul:nth-child(3) div.cr_data_field')

    result = {}
    data_divs.each do |div|
      key_el = div.at_css('h5.data_lbl')
      value_el = div.at_css('span.data_data')

      data = {}
      value_el.children.each do |child|
        next unless NokogiriUtil::node_is_present?(child)

        content = child.content.strip

        if child.text?
          data[ResponseConstants::Keys::VALUE] = content.match(DATE_REGEX) ? NokogiriUtil.parse_date(content) : content
        elsif child.element?
          if child.name == 'sup'
            data[ResponseConstants::Keys::PREFIX] = content
          elsif child['class'] == 'data_meta'
            metadata = {}
            dates = content.scan DATE_REGEX
            case dates.length
            when 0
              metadata[ResponseConstants::Keys::TYPE] = ResponseConstants::ValueTypes::TEXT
              metadata[ResponseConstants::Keys::VALUE] = content
            when 1
              metadata[ResponseConstants::Keys::TYPE] = ResponseConstants::ValueTypes::DATE
              metadata[ResponseConstants::Keys::VALUE] = NokogiriUtil::parse_date(dates.first)
            when 2
              metadata[ResponseConstants::Keys::TYPE] = ResponseConstants::ValueTypes::DATE_RANGE
              metadata[ResponseConstants::Keys::VALUE] = {
                ResponseConstants::Keys::START_DATE => NokogiriUtil::parse_date(dates.first),
                ResponseConstants::Keys::END_DATE => NokogiriUtil::parse_date(dates.last)
              }
            else
              metadata[ResponseConstants::Keys::TYPE] = ResponseConstants::ValueTypes::DATES
              metadata[ResponseConstants::Keys::VALUE] = dates.map { |date_s| NokogiriUtil::parse_date(date_s) }
            end

            data[ResponseConstants::Keys::METADATA] = metadata
          end
        end
      end

      result[key_el.content.strip] = data
    end

    result
  end

  def self.parse_short_interest_data(doc)
    container_div = doc.at_css('div.cr_data_points:nth-child(2)')
    date_s = container_div.at_css('h3:nth-child(2) > span:nth-child(1)').content.match(DATE_REGEX).to_s
    data_divs = container_div.css('div.cr_data_field')

    result = { ResponseConstants::Keys::DATE => NokogiriUtil::parse_date(date_s) }
    data_divs.each do |div|
      key_el = div.at_css('h5.data_lbl')
      value_el = div.at_css('span.data_data')

      data = {}
      value_el.children.each do |child|
        data[ResponseConstants::Keys::VALUE] = child.content.strip unless NokogiriUtil::node_is_blank?(child)
      end

      result[key_el.content.strip] = data
    end

    result
  end

end
