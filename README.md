# RAKE-NLP

> Ruby implementation of the Rapid Automatic Keyword Extraction (RAKE) algorithm

## Usage

```ruby
text = "Criteria of compatibility of a system of linear Diophantine equations, strict inequations, and nonstrict inequations are considered. Upper bounds for components of a minimal set of solutions and algorithms of construction of minimal generating sets of solutions for all types of systems are given. These criteria and the corresponding algorithms for constructing a minimal supporting set of solutions can be used in solving all the considered types of systems and systems of mixed types."

result = RakeNLP.run(text, {
  min_phrase_length: 1,
  max_phrase_length: 3,
  min_frequency:     1,
  min_score:         1,
  stop_list:         RakeNLP::StopList::SMART
})

result.keywords
```

```ruby
=> {"linear diophantine equations"=>9.0, "minimal generating sets"=>8.666666666666666, "minimal supporting set"=>8.166666666666666, "minimal set"=>5.166666666666666, "upper bounds"=>4.0, "nonstrict inequations"=>4.0, "strict inequations"=>4.0, "mixed types"=>3.666666666666667, "considered types"=>3.166666666666667, "types"=>1.6666666666666667, "considered"=>1.5, "solving"=>1.0, "constructing"=>1.0, "systems"=>1.0, "construction"=>1.0, "algorithms"=>1.0, "solutions"=>1.0, "components"=>1.0, "system"=>1.0, "compatibility"=>1.0, "criteria"=>1.0}
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
