require 'alm'

# a single source
Lagotto.sources(source: 'twitter', per_page: 2)
Lagotto.sources(source: 'mendeley', per_page: 3)
Lagotto.sources(source: 'facebook', per_page: 1, info: "detail")

# many sources
sources = ['facebook','twitter','mendeley']
sources.collect { |x| Lagotto.sources(source: x, per_page: 1) }
