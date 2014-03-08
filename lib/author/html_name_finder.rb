require 'nokogiri'

module Author
  class HTMLNameFinder
    RULES = [
      ["meta[@property='og:site_name']", :content_value],
      ["meta[@property='og:article:author']", :content_value],
      ["meta[@property='article:author']", :content_value],
      ["meta[@name='author']", :content_value],
      ["meta[@itemprop='creator']", :content_value],
      ["meta[@name='octolytics-dimension-user_login']", :content_value],
      [".authorname a", :text],
      [".authorname", :text],
      [".author a", :text],
      [".author", :text],
      [".byline .fn", :text],
      [".by-line a", :text],
      [".by-line", :text],
      [".byline a", :text],
      [".byline", :text],
      [".by a", :text],
      [".blogger-description", :text],
      [".author_name", :text],
      [".attribution", :text],
      [".authorship img", :alt]
    ]

    def initialize(html)
      @html = html
      @doc = Nokogiri::HTML(html)
    end

    def names
      names = []

      RULES.each do |rule|
        el = @doc.css(rule[0])

        next unless el && el[0]

        val = case rule[1]
          when :text
            el.text
          when :alt
            el.attr('alt').value
          when :content_value
            el.attr('content').value
          else
            el.text
        end

        next unless val.to_s.length > 2

        val.strip!
        val.gsub!(/\s+/, ' ')
        val.gsub!(/[^\w\s]/, '')

        names << val if val.to_s.length > 2
      end

      names
    end
  end
end
