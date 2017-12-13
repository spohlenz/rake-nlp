module RakeNLP
  class StopList
    def initialize(words)
      @words = words
    end

    def to_a
      @words
    end

    def to_regex
      @regex ||= /#{@words.map { |w| "\\b#{w}(?![\\w-])" }.join("|")}/i
    end

    def self.read(filename)
      new(File.read(filename).split("\n").reject { |line| line =~ /^#/ })
    end

    SMART = read(File.join(File.dirname(__FILE__), "../../data/SmartStopList.txt"))
    FOX   = read(File.join(File.dirname(__FILE__), "../../data/FoxStopList.txt"))
  end
end
