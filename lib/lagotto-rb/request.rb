require "faraday"
require "multi_json"

##
# Lagotto::Request
module Lagotto
  class Request #:nodoc:

    attr_accessor :url
    attr_accessor :path
    attr_accessor :ids
    attr_accessor :type
    attr_accessor :info
    attr_accessor :source
    attr_accessor :publisher
    attr_accessor :order
    attr_accessor :per_page
    attr_accessor :page
    attr_accessor :key
    attr_accessor :options
    attr_accessor :verbose

    def initialize(url, path, ids, type, info, source,
      publisher, order, per_page, page, key,
      options, verbose)

      self.url = url
      self.path = path
      self.ids = ids
      self.type = type
      self.info = info
      self.source = source
      self.publisher = publisher
      self.order = order
      self.per_page = per_page
      self.page = page
      self.key = key
      self.options = options
      self.verbose = verbose
    end

    def perform
      args = { ids: self.ids, type: self.type,
              info: self.info, source: self.source, publisher: self.publisher,
              order: self.order, per_page: self.per_page,
              page: self.page, api_key: self.key }
      opts = args.delete_if { |k, v| v.nil? }

      if verbose
        conn = Faraday.new(:url => self.url, :request => options) do |f|
          f.response :logger
          f.headers['Accept'] = 'application/json'
          f.adapter  Faraday.default_adapter
        end
      else
        conn = Faraday.new(:url => self.url, :request => options) do |f|
          f.headers['Accept'] = 'application/json'
          f.adapter  Faraday.default_adapter
        end
      end
      puts conn
      res = conn.get self.path, opts

      return MultiJson.load(res.body)
    end
  end
end
