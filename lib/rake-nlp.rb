require "rake-nlp/version"
require "rake-nlp/stop_list"
require "rake-nlp/result"

module RakeNLP
  DEFAULTS = {
    min_phrase_length: 1,
    max_phrase_length: 3,
    min_frequency:     1,
    min_score:         1,
    stop_list:         StopList::SMART
  }

  def self.run(text, options={})
    RakeNLP::Result.new(text, DEFAULTS.merge(options))
  end
end
