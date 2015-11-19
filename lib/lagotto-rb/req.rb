require "faraday"
require "multi_json"

##
# Lagotto::BasicRequest
module Lagotto
  class BasicRequest #:nodoc:

    attr_accessor :url
    attr_accessor :path
    attr_accessor :key
    attr_accessor :options
    attr_accessor :verbose

    def initialize(url, path, key, options, verbose)

      self.url = url
      self.path = path
      self.key = key
      self.options = options
      self.verbose = verbose
    end

    def perform
      args = { api_key: self.key }
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

      res = conn.get self.path, opts

      return MultiJson.load(res.body)
    end
  end
end
