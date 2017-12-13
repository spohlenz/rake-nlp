lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rake-nlp/version"

Gem::Specification.new do |spec|
  spec.name          = "rake-nlp"
  spec.version       = RakeNLP::VERSION
  spec.authors       = ["Sam Pohlenz"]
  spec.email         = ["sam@sampohlenz.com"]

  spec.summary       = "Implementation of the Rapid Automatic Keyword Extraction (RAKE) algorithm"
  spec.description   = "Implementation of the Rapid Automatic Keyword Extraction (RAKE) algorithm"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
