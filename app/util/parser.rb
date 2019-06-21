class Parser

  DATE_REGEX = /\d{2}\/\d{2}\/\d{2}/

  def self.parse_key_stock_data(doc)
    data_divs = doc.css('div.cr_data_points:nth-child(1) > ul:nth-child(3) div.cr_data_field')

    result = Hash.new

    data_divs.each do |div|
      key_el = div.at_css('h5.data_lbl')
      value_el = div.at_css('span.data_data')

      data = Hash.new
      
      value_el.children.each do |child|
        next unless NokogiriUtil::node_is_present?(child)

        content = child.content.strip

        if child.text?
          if content.match(DATE_REGEX)
            data['value'] = NokogiriUtil.parse_date(content)
          else
            data['value'] = content
          end
        elsif child.element?
          if child.name == 'sup'
            data['prefix'] = content
          elsif child['class'] == 'data_meta'
            metadata = Hash.new
            dates = content.scan DATE_REGEX
            case dates.length
            when 0
              metadata['type'] = 'text'
              metadata['value'] = content
            when 1
              metadata['type'] = 'date'
              metadata['value'] = NokogiriUtil::parse_date(dates.first)
            when 2
              metadata['type'] = 'date_range'
              metadata['value'] = {
                'start': NokogiriUtil::parse_date(dates.first),
                'end': NokogiriUtil::parse_date(dates.last)
              }
            else
              metadata['type'] = 'dates'
              metadata['value'] = dates.map { |date_s| NokogiriUtil::parse_date(date_s) }
            end

            data['metadata'] = metadata
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

    result = {
      'date': NokogiriUtil::parse_date(date_s)
    }

    data_divs.each do |div|
      key_el = div.at_css('h5.data_lbl')
      value_el = div.at_css('span.data_data')

      data = Hash.new

      value_el.children.each do |child|
        next unless NokogiriUtil::node_is_present?(child)

        content = child.content.strip

        if child.element? && child['class'].start_with?('marketDelta') && child['class'].end_with?('negative')
          data['value'] = "-#{content}"
        else
          data['value'] = content
        end
      end

      result[key_el.content.strip] = data
    end

    result
  end

end
