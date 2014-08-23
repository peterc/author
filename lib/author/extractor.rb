module Author
  class Extractor
    attr_reader :name_detector

    def initialize(options = {})
      defaults = {
        :type => :text,
        :content => ''
      }

      @options = defaults.merge(options)
      @content = @options[:content]
      @potential_names = []

      if @options[:type] == :html
        @nokogiri_doc = Nokogiri::HTML(@content)
      end
    end

    # going to be REAL MESSY for now..
    def extract
      if @options[:type] == :text
        @potential_names += @content.split(/\n/)
      elsif @options[:type] == :html
        @potential_names += HTMLNameFinder.new(@content).names
        @potential_names += @nokogiri_doc.css("title, p, li, span, a").map(&:text)
      end

      @name_detector = NameDetector.new(@potential_names)

      @extract = @name_detector.extract_names
    end

    def best_match
      extract unless @extract
      @name_detector.best_match
    end
  end
end
