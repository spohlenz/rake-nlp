module RakeNLP
  class Result
    SENTENCE_REGEX = /[\\[\\]\n.!?,;:\t\\-\\"\\(\\)\\\'\u2019\u2013]/
    WORD_REGEX = /[^a-zA-Z0-9_\+\-\/]/
    NUMBER_REGEX = /^-*[0-9,\.]+$/

    def initialize(text, options={})
      @text, @options = text, options
      @stoplist_regex = options[:stop_list].to_regex
    end

    def sentences
      @text.split(SENTENCE_REGEX).map(&:strip)
    end

    def phrases
      @phrases ||= begin
        sentences.map { |sentence|
          sentence.downcase.split(@stoplist_regex).map(&:strip).select { |phrase| acceptable?(phrase) }
        }.flatten
      end
    end

    def word_scores
      @word_scores ||= begin
        frequencies = Hash.new(0)
        degrees = Hash.new(0)

        phrases.each do |phrase|
          words = split_words(phrase)
          words.each do |word|
            frequencies[word] += 1
            degrees[word] += words.length - 1
          end
        end

        frequencies.each do |word, frequency|
          degrees[word] += frequency
        end

        scores = {}
        frequencies.each do |word, frequency|
          scores[word] = degrees[word] / frequency.to_f
        end
        scores
      end
    end

    def keywords
      keywords = Hash.new(0)

      phrases.each do |phrase|
        if @options[:min_frequency] > 1
          next if phrases.count(phrase) < @options[:min_frequency]
        end

        words = split_words(phrase)
        keywords[phrase] = words.map { |word| word_scores[word] }.sum
      end

      keywords.select { |word, score|
        score >= @options[:min_score]
      }.sort_by(&:last).reverse.to_h
    end

  private
    def split_words(str)
      str.split(WORD_REGEX).reject { |word| word =~ NUMBER_REGEX }
    end

    def acceptable?(phrase)
      !phrase.empty? &&
        phrase.length >= @options[:min_phrase_length] &&
        phrase.split(/\s/).length <= @options[:max_phrase_length] &&
        phrase.scan(/[a-zA-Z]/).length > 0 &&
        phrase.scan(/[a-zA-Z]/).length > phrase.scan(/\d/).length
    end
  end
end
