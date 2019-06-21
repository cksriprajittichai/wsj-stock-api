require 'open-uri'

module NokogiriUtil

  def self.get_html(url)
    Nokogiri::HTML(open(url))
  end

  def self.node_is_blank?(node)
    (node.text? && node.content.strip.empty?) || (node.element? && node.name == 'br')
  end

  def self.node_is_present?(node)
    !node_is_blank?(node)
  end

  def self.parse_date(date_s)
    Date.strptime(date_s, '%m/%d/%y')
  end

end
