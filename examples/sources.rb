require 'alm'

# a single source
Alm.sources(source: 'twitter', key: ENV['PLOS_API_KEY'], per_page: 2)
Alm.sources(source: 'mendeley', key: ENV['PLOS_API_KEY'], per_page: 3)
Alm.sources(source: 'facebook', key: ENV['PLOS_API_KEY'], per_page: 1, info: "detail")

# many sources
sources = ['facebook','twitter','mendeley']
sources.collect { |x| Alm.sources(source: x, key: ENV['PLOS_API_KEY'], per_page: 1) }
