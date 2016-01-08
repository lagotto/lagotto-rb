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

## Changes

For changes see the [Changelog][changelog]

## API

Methods in relation to [Lagotto API][lapi] routes

* `/works` - `Lagotto.works()`
* `/works_sources` - `Lagotto.works_sources()`
* `/events` - `Lagotto.events()`
* `/publishers` - `Lagotto.publishers()`
* `/groups` - `Lagotto.groups()`
* `/references` - `Lagotto.references()`
* `/work_types` - `Lagotto.work_types()`
* `/docs` - `Lagotto.docs()`
* `/relation_types` - `Lagotto.relation_types()`
* `/sources` - `Lagotto.sources()`
* `/recommendations` - `Lagotto.recommendations()`
* `/status` - `Lagotto.status()`

## Install

### Release version

```
gem install lagotto-rb
```

### Development version

Install dependencies

```
git clone git@github.com:sckott/serrano.git
cd serrano
rake install
```

### In Ruby repl

Get altmetrics by DOI

```ruby
Lagotto.works(ids: 'http://doi.org/10.15468/DL.SQNY5P', instance: "crossref")
```

Search for altmetrics by source

```ruby
Lagotto.works(source: 'twitter', instance: "crossref")
```

Make a `/works` route request by source

```ruby
Lagotto.works_sources(source: 'twitter', per_page: 2)
```

Make a `/events` route request

```ruby
Lagotto.events(ids: '10.1371/journal.pone.0029797', instance: "crossref")
```

Make a `/publishers` route request

```ruby
Lagotto.publishers(id: 340)
```

Make a `/groups` route request

```ruby
Lagotto.groups()
```

Make a `/references` route request

```ruby
Lagotto.references(per_page: 5, instance: 'crossref')
```

### On the CLI

```
~$ lagotto
Commands:
  lagotto help [COMMAND]  # Describe available commands or one specific command
  lagotto version         # Get lagotto-rb version
  lagotto works [ids]     # Get works by ids
```

```
# A single id
~$ lagotto works http://doi.org/10.1371/journal.pone.0025110

DOI: 10.1371/journal.pone.0033693
type: journal-article
title: Methylphenidate Exposure Induces Dopamine Neuron Loss and Activation of Microglia in the Basal Ganglia of Mice

# JSON output
~$ lagotto works --limit=2 --json

{"meta":{"status":"ok","message-type":"work-list", ...

# JSON output, parse with jq
~$ lagotto works --limit=2 --json | jq .works[].DOI

"10.1371/journal.pgen.1005692"
"10.1371/journal.pgen.1005425"
```

## Meta

* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
* License: MIT

[lapi]: http://alm.plos.org/docs/api
