require 'httparty'
require 'json'

require "lagotto-rb/version"
require "lagotto-rb/request"
require "lagotto-rb/req"
require "lagotto-rb/helpers"

# @!macro lagotto_params
#   @param type [String] One of doi, pmid, pmcid, or mendeley_uuid
#   @param source [String] One source. To get many sources, make many calls.
#   @param publisher [String] Filter articles to a given publisher, using a crossref_id.
#   @param order [String] Results are sorted by descending event count when given the source name, e.g. `&order=wikipedia`. Otherwise (the default) results are sorted by date descending. When using `&source=x`, we can only sort by data or that source, not a different source.
#   @param per_page [String] Items per page
#   @param page [String] Page to retrieve
#   @param instance [String] One of plos, crossref, pkp, elife, copernicus, pensoft
#   @param key [String] API key
#   @param verbose [Boolean] Print request headers to stdout. Default: false

# @!macro lagotto_options
#   @param options [Hash] Hash of options for configuring the request, passed on to Faraday.new
#     :timeout      - [Fixnum] open/read timeout Integer in seconds
#     :open_timeout - [Fixnum] read timeout Integer in seconds
#     :proxy        - [Hash] hash of proxy options
#       :uri - [String] Proxy Server URI
#       :user - [String] Proxy server username
#       :password - [String] Proxy server password
#     :params_encoder - [Hash] not sure what this is
#     :bind           - [Hash] A hash with host and port values
#     :boundary       - [String] of the boundary value
#     :oauth          - [Hash] A hash with OAuth details

##
# Lagotto - The top level module for using methods
# to access a Lagotto instance API
#
# The following methods, matching the main Crossref API routes, are available:
# * `Lagotto.works` - Use the /works endpoint
# * `Lagotto.status` - Get instance status, requires authentication
# * `Lagotto.requests` - Search requests, requires authentication
# * `Lagotto.alerts` - Search alerts, requires authentication
# * `Lagotto.events` - Get events back
# * `Lagotto.sources` - Search /works routes by source
module Lagotto
  ##
  # Make a `/works` route request
  #
  # @!macro lagotto_params
  # @!macro lagotto_options
  # @return [Hash] A hash
  #
  # @example
  #      require 'lagotto-rb'
  #      Lagotto.works(ids: 'http://doi.org/10.15468/DL.SQNY5P', instance: "crossref")
  #      Lagotto.works(ids: ['http://doi.org/10.1371/journal.pone.0029797','http://doi.org/10.1016/j.dsr2.2010.10.029'], instance: "crossref")
  #      Lagotto.works(ids: 'http://doi.org/10.1371/journal.pone.0025110', instance: "plos")
  #      ids = ["http://doi.org/10.1371/journal.pone.0029797","http://doi.org/10.1371/journal.pone.0029798"]
  #      Lagotto.works(ids: ids, instance: "plos")
  #      Lagotto.works(ids: '10.4081/audiores.2013.e1', key: ENV['PKP_API_KEY'], instance: "pkp")
  #
  #      # Search by source
  #      Lagotto.works(source: 'twitter', instance: "crossref")
  #      Lagotto.works(instance: "crossref", per_page: 5)
  #
  #      # get by publisher
  #      Lagotto.works(publisher: 311, info: "summary")
  def self.works(ids: nil, type: nil, source: nil, publisher: nil,
            order: nil, per_page: 50, page: 1, instance: 'plos', key: nil,
            options: nil, verbose: false)

    test_length(source)
    type_check(page, Fixnum)
    type_check(per_page, Fixnum)
    # test_values('info', info, ['summary','detail'])
    # test_values('id_type', id_type, ['doi','pmid','pmcid','mendeley_uuid'])
    # test_values('instance', instance, ['plos','crossref','copernicus','elife','pensoft','pkp'])

    url = pick_url(instance)
    ids = join_ids(ids)
    Request.new(url, 'works', ids, type, source,
      publisher, order, per_page, page, key, options, verbose).perform
  end

  ##
  # Make a `/status` route request
  #
  # @param key [String] API key
  # @param instance [String] One of plos, crossref, pkp, elife, copernicus, pensoft
  # @param verbose [Boolean] Print request headers to stdout. Default: false
  # @!macro lagotto_options
  # @return [Hash] A hash
  #
  # @example
  #      require 'lagotto-rb'
  #      Lagotto.status(key: ENV['PLOS_API_KEY'])
  def self.status(key: nil, instance: 'plos', options: nil, verbose: false)
    url = pick_url(instance)
    BasicRequest.new(url, 'status', key, options, verbose).perform
  end

  def self.alerts(source: nil, ids: nil, class_name: nil, level: nil, q: nil,
    unresolved: nil, per_page: 50, page: 1, user: nil, pwd: nil,
    instance: 'plos', options: {})

    url = pick_url_alerts(instance)
    # userpwd = getuserinfo(user, pwd)
    options = {
      query: {
        q: q,
        class_name: class_name,
        source: source,
        level: level,
        unresolved: unresolved,
        ids: ids,
        rows: per_page,
        page: page
      },
      basic_auth: { username: user, password: pwd }
    }
    options[:query] = options[:query].reject{ |i,j| j == nil }
    res = HTTParty.get(url, options)
    response_ok(res.code)
    return res
  end

  ##
  # Make a `/works` route request by source
  #
  # @param source [String] One source. To get many sources, make many calls.
  # @param per_page [String] Items per page
  # @param page [String] Page to retrieve
  # @param instance [String] One of plos, crossref, pkp, elife, copernicus, pensoft
  # @param key [String] API key
  # @param verbose [Boolean] Print request headers to stdout. Default: false
  # @!macro lagotto_options
  # @return [Hash] A hash
  #
  # @example
  #    # a single source
  #    Lagotto.sources(source: 'twitter', per_page: 2)
  #    Lagotto.sources(source: 'mendeley', per_page: 3)
  #    Lagotto.sources(source: 'facebook', per_page: 1)

  #    # many sources
  #    sources = ['facebook','twitter','mendeley']
  #    sources.collect { |x| Lagotto.sources(source: x, per_page: 1) }
  def self.sources(source: nil, per_page: 50, page: 1, instance: 'plos', key: nil,
    options: nil, verbose: false)

    url = pick_url(instance)
    Request.new(url, 'works', nil, nil, source,
      nil, nil, per_page, page, key, options, verbose).perform
  end

  ##
  # Make a `/events` route request
  #
  # @!macro lagotto_params
  # @!macro lagotto_options
  # @return [Hash] A hash
  #
  # @example
  #   # Get events by DOI
  #   ## swap out the key and instance to change provider
  #   Lagotto.events(ids: '10.1371/journal.pone.0029797', instance: "crossref")
  #   Lagotto.events(ids: ['10.1371/journal.pone.0029797','10.1016/j.dsr2.2010.10.029'], instance: "crossref")
  #   Lagotto.events(ids: '10.4081/audiores.2013.e1', instance: "pkp")
  #   Lagotto.events(ids: "10.1371/journal.pone.0029797")
  #   ids = ["10.1371/journal.pone.0029797","10.1371/journal.pone.0029798"]
  #   Lagotto.events(ids: ids)
  #
  #   # Search by source
  #   Lagotto.events(source: 'twitter', instance: "crossref")
  #   Lagotto.events(instance: "crossref", per_page: 5)
  #
  #   # Get data by publisher
  #   ids = HTTParty.get("http://api.crossref.org/members")
  #   ids = ids['message']['items'].collect { |p| p['id'] }
  #   Lagotto.events(publisher: ids[0], info: "summary")
  def self.events(ids: nil, type: nil, source: nil, publisher: nil,
    order: nil, per_page: 50, page: 1, instance: 'plos', key: nil,
    options: nil, verbose: false)

    test_length(source)
    type_check(page, Fixnum)
    type_check(per_page, Fixnum)
    url = pick_url(instance)
    ids = join_ids(ids)
    Request.new(url, 'events', ids, type, source,
      publisher, order, per_page, page, key, options, verbose).perform
  end

end
