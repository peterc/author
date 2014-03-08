module Author
  class NameDetector
    def self.extract(text)
      self.new.extract(text)
    end

    def extract(text)
      text
    end
  end
end
