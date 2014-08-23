module Author
  class NameDetector
    def self.extract(text); self.new(text).extract; end
    def self.extract_names(text); self.new(text).extract_names; end

    def initialize(text)
      @text = [*text]
    end

    def best_match
      names = extract_names

      names.sort_by(&:last).last[0] if names
    end

    def extract_names
      names = []

      likelihoods.each do |likelihood_set|
        running_score = 0
        name = []
        scores = []

        likelihood_set.each do |(word, info)|
          score = info[:score]

          scores << score
          threshold = 3
          threshold = -1 if scores[-2] && scores[-2] > 4
          threshold = -3 if scores[-2] && scores[-2] > 10

          if score > threshold
            name << word
            running_score += score
          elsif name.length > 1
            names << [name.join(' '), running_score / name.length] if running_score > 0
            running_score = 0
            name = []
          else
            name = []
            running_score = 0
          end
        end

        if name.length > 1
          names << [name.join(' '), running_score]
        end
      end

      names.empty? ? nil : names.group_by { |(a,b)| a }.map { |k, v| [k, v.inject(0) { |i, j| i + j[1] }] }
    end

    def likelihoods
      word_likelihoods.each do |word_set_l|
        word_set_l.map.with_index do |word, i|
          previous_word = i > 0 ? word_set_l[i - 1] : nil

          score_effect = 0

          if previous_word && previous_word[0] && word && word[0]
            score_effect += 1 if previous_word[0] =~ /^\d+$/    # could be following a copyright notice
            score_effect += 6 if previous_word[0] == 'By'
            score_effect += 4 if previous_word[0] == 'by'
            score_effect += 1 if previous_word[0] == 'am'
            score_effect += 2 if previous_word[0] == '&copy;'

            # We don't like case changing on us mid-name
            score_effect -= 3 if previous_word[0][0] =~ /[A-Z]/ && word[0][0] =~ /[a-z]/
            score_effect -= 2 if previous_word[0][0] =~ /[a-z]/ && word[0][0] =~ /[A-Z]/
          end

          word[1][:score] += score_effect
          word
        end
      end
    end

    def word_likelihoods
      @word_likelihoods ||= word_sets.map do |word_set|
        words(word_set).map do |word|
          clean_word = word[/\w+/]
          [clean_word, word_likelihood(word)]
        end
      end
    end

    def word_likelihood(word)
      type = nil
      score = 0
      score -= 10 if STOPWORDS.include?(word.downcase)

      if NAMES.include?(word.downcase)
        if word =~ /^[A-Z][a-z]/
          score += 15
        elsif WORDNAMES.include?(word)
          score += 2
        else
          score += 6
        end
        type = :first
      end

      score -= 3 if word =~ /^[A-Z]+$/

      if word =~ /^[A-Z][a-z]+/
        score += 4
        type ||= :part_of_name
      end

      score -= 1 if word =~ /^[a-z]/ && score > 0
      score -= 5 if word =~ /["!?:{}<>\\\/=+_()*;|]/

      score -= 10 if word =~ /^\d+/

      score -= 1 if word =~ /['\-&,\.]/
      score += 1 if word =~ /\.$/
      score += 1 if word =~ /\'s$/

      if word =~ /^[A-Z]\.$/
        score += 4
        type = :initial
      end

      if word =~ /^[A-Z]$/
        score += 2
        type = :initial
      end

      score -= 5 if word.length > 10

      score -= 10 if word =~ /^[A-Z][a-z]+[A-Z][A-Z]/

      score -= 5 if word.strip.length < 1
      score += 20 if TITLES.include?(word[/^(\w+)/, 1])
      { :type => type, :score => score }
    end

    def word_sets
      @text.map { |t| t.split("\n") }.flatten
    end

    def words(word_set)
      word_set.split(/\s+/)
    end
  end
end
