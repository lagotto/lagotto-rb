lagotto-rb
==========

[![Build Status](https://api.travis-ci.org/lagotto/lagotto-rb.png)](https://travis-ci.org/lagotto/lagotto-rb)

__This is alpha software, so expect changes__

__`lagotto-rb` - a Ruby client for the Lagotto application for article level metrics data__

## Dependencies

* `HTTParty` gem to make web calls to Crossref APIs
* `json` gem to convert to/from JSON
* `bundler`
* `rake`

## Install

### Development version

Install dependencies

```
gem install httparty json rake
sudo gem install bundler
git clone https://github.com/lagotto/lagotto-rb.git
cd lagotto-rb
bundle install
```

After `bundle install` the `lagotto-rb` gem is installed and available on the command line or in a Ruby repl.

### In Ruby repl

Get altmetrics by DOI

```ruby
Alm.alm(ids: '10.1371/journal.pone.0029797', key: '<key>', instance: "crossref")
```

```ruby
=> "{\"total\":1,\"total_pages\":1,\"page\":1,\"error\":null,\"data\":[{\"doi\":\"10.1371/journal.pone.0029797\",\"title\":\"Ecological Guild Evolution and the Discovery of the World's Smallest Vertebrate\",\"issued\":{\"date-parts\":[[2012,1,11]]},\"canonical_url\":null,\"pmid\":\"22253785\",\"pmcid\":\"3256195\",\"mendeley_uuid\":null,\"viewed\":0,\"saved\":0,\"discussed\":0,\"cited\":0,\"update_date\":\"2014-11-15T20:59:22Z\"}]}"
```

Search for altmetrics by source

```ruby
Alm.alm(source: 'twitter', key: ENV['CROSSREF_API_KEY'], instance: "crossref")
```

```ruby
"xxx"
```

### Command line

_not quite done yet_
