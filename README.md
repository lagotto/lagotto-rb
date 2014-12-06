alm
======

[![Build Status](https://api.travis-ci.org/sckott/alm.png)](https://travis-ci.org/sckott/alm)

__This is alpha software, so expect changes__

__`alm` - a Ruby client for the Lagotto application for article level metrics data__

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
git clone https://github.com/sckott/alm.git
cd alm
bundle install
```

After `bundle install` the `alm` gem is installed and available on the command line or in a Ruby repl.

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

```

### Command line

_not quite done yet_
