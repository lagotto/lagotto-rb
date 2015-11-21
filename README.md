lagotto-rb
==========

[![Build Status](https://api.travis-ci.org/lagotto/lagotto-rb.png)](https://travis-ci.org/lagotto/lagotto-rb)
[![gem version](https://img.shields.io/gem/v/lagotto-rb.svg)](https://rubygems.org/gems/lagotto-rb)
[![codecov.io](http://codecov.io/github/lagotto/lagotto-rb/coverage.svg?branch=master)](http://codecov.io/github/lagotto/lagotto-rb?branch=master)

__This is alpha software, so expect changes__

__`lagotto-rb` - a Ruby client for the Lagotto application for article level metrics data__

Other Lagotto clients:

* R - [alm](https://github.com/ropensci/alm)
* Python - [pyalm](https://github.com/lagotto/pyalm)

## Dependencies

* `HTTParty` gem to make web calls to Crossref APIs
* `json` gem to convert to/from JSON
* `bundler`
* `rake`

## Install

### Release version

```
gem install lagotto-rb
```

### Development version

Install dependencies

```
gem install httparty json rake
sudo gem install bundler
git clone https://github.com/lagotto/lagotto-rb.git
cd lagotto-rb
bundle install
```

### In Ruby repl

Get altmetrics by DOI

```ruby
Lagotto.works(ids: 'http://doi.org/10.15468/DL.SQNY5P', instance: "crossref")
```

```ruby
=> {"meta"=>
  {"status"=>"ok",
   "message-type"=>"work-list",
   "message-version"=>"6.0.0",
   "total"=>1,
   "total_pages"=>1,
   "page"=>1},
 "works"=>
  [{"id"=>"http://doi.org/10.15468/DL.SQNY5P",
    "author"=>[{"family"=>"gbif.org"}],
    "title"=>"GBIF Occurrence Download",
    "issued"=>{"date-parts"=>[[2015]]},
    "DOI"=>"10.15468/DL.SQNY5P",
    "events"=>{},
    "timestamp"=>"2015-11-18T16:11:46Z"}]}
```

Search for altmetrics by source

```ruby
Lagotto.works(source: 'twitter', instance: "crossref")
```

```ruby
=> {"meta"=>
  {"status"=>"ok",
   "message-type"=>"work-list",
   "message-version"=>"6.0.0",
   "total"=>62467,
   "total_pages"=>1250,
   "page"=>1},
 "works"=>
  [{"id"=>"http://doi.org/10.15468/SQZYAJ",
    "author"=>
     [{"literal"=>"46fec380-8e1d-11dd-8679-b8a03c50a862",
       "ORCID"=>"http://orcid.org/46fec380-8e1d-11dd-8679-b8a03c50a862"}],
    "title"=>"Kartlegging av spredning av fremmede bartrær",
    "issued"=>{"date-parts"=>[[2015]]},
    "DOI"=>"10.15468/SQZYAJ",
    "events"=>{},
    "timestamp"=>"2015-11-18T16:34:52Z"},
   {"id"=>"http://doi.org/10.15468/DL.N7WA77",
    "author"=>[{"family"=>"gbif.org"}],
    "title"=>"GBIF Occurrence Download",
    "issued"=>{"date-parts"=>[[2015]]},
    "DOI"=>"10.15468/DL.N7WA77",
    "events"=>{},
    "timestamp"=>"2015-11-18T16:34:16Z"},

...
```

### To DO

* Command line

## Meta

* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
* License: MIT
