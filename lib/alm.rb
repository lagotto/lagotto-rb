require 'httparty'
require 'json'

module Alm
  ##
  # Get a single citation in various formats from a DOI
  #
  # Args:
  # * ids: One or more DOIs
  # * type: One of doi, pmid, pmcid, or mendeley_uuid
  # * info: One of summary or detail
  # * source: One source. To get many sources, make many calls.
  # * publisher: Filter articles to a given publisher, using a crossref_id.
  # * order: Results are sorted by descending event count when given the source
  #  name, e.g. &order=wikipedia. Otherwise (the default) results are sorted by
  #  date descending. When using &source=x, we can only sort by data or that source,
  #  not a different source.
  # * per_page: Items per page
  # * page: Page to retrieve
  # * instance: One of plos, crossref, pkp, elife, copernicus, pensoft
  # * key: API key
  # * options: Options to pass on to HTTParty.get
  #
  # Usage:
  # Alm.alm(ids: '10.1371/journal.pone.0029797', key: ENV['CROSSREF_API_KEY'], instance: "crossref")
  # Alm.alm(ids: ['10.1371/journal.pone.0029797','10.1016/j.dsr2.2010.10.029'], key: ENV['CROSSREF_API_KEY'], instance: "crossref")
  # Alm.alm(ids: '10.4081/audiores.2013.e1', key: ENV['PKP_API_KEY'], instance: "pkp")
  # Alm.alm(ids: '10.1371/journal.pone.0025110', key: ENV['PLOS_API_KEY'], instance: "plos")
  # ids = ["10.1371/journal.pone.0029797","10.1371/journal.pone.0029798"]
  # Alm.alm(ids: ids, key: ENV['PLOS_API_KEY'], instance: "plos")
  #
  # # Search by source
  # Alm.alm(source: 'twitter', key: ENV['CROSSREF_API_KEY'], instance: "crossref")
  # Alm.alm(instance: "crossref", per_page: 5, key: ENV['CROSSREF_API_KEY'])
  #
  # # get by publisher
  # require 'HTTParty'
  # ids = HTTParty.get("http://api.crossref.org/members")
  # ids = ids['message']['items'].collect { |p| p['id'] }
  # Alm.alm(publisher: ids[0], info: "summary")

  def self.alm(ids: nil, type: nil, info: 'summary',
            source: nil, publisher: nil, order: nil, per_page: 50,
            page: 1, instance: 'plos', key: nil, options: {})

    test_length(source)
    type_check(page, Fixnum)
    type_check(per_page, Fixnum)
    # test_values('info', info, ['summary','detail'])
    # test_values('id_type', id_type, ['doi','pmid','pmcid','mendeley_uuid'])
    # test_values('instance', instance, ['plos','crossref','copernicus','elife','pensoft','pkp'])

    url = pick_url(instance)
    ids = join_ids(ids)
    options = {
      query: {
        ids: ids,
        info: info,
        publisher: publisher,
        type: type,
        source: source,
        order: order,
        per_page: per_page,
        page: page,
        api_key: key
      },
      headers: {"Accept" => 'application/json'}
    }
    res = HTTParty.get(url+'/articles', options)
    response_ok(res.code)
    return res
  end

  def self.requests(key: nil, instance: 'plos', options: {})
    url = pick_url(instance)
    options = {
      query: {
        api_key: key
      },
      headers: {"Accept" => 'application/json'}
    }
    res = HTTParty.get(url+'/api_requests', options)
    response_ok(res.code)
    return res
  end

  def self.status(key: nil, instance: 'plos', options: {})
    url = pick_url(instance)
    options = {
      query: {
        api_key: key
      },
      headers: {"Accept" => 'application/json'}
    }
    res = HTTParty.get(url+'/status', options)
    response_ok(res.code)
    return res
  end

  def self.signposts(ids: nil, type: nil, info: 'summary',
            source: nil, publisher: nil, order: nil, per_page: 50,
            page: 1, instance: 'plos', key: nil, options: {})

    temp = Alm.alm(ids: ids, type: type, info: info,
            source: source, publisher: publisher, order: order, per_page: per_page,
            page: page, instance: instance, key: key, options: options)
    res = temp['data'].collect { |p| {"doi"=>p['doi'],"viewed"=>p['viewed'],"saved"=>p['saved'],"discussed"=>p['discussed'],"cited"=>p['cited']} }
    return res
  end

end


def response_ok(code)
  # See CrossCite documentation http://crosscite.org/cn/
  case code
    when 200
      return true
    when 204
      raise "The request was OK but there was no metadata available (response code: #{code})"
    when 404
      raise "The DOI requested doesn't exist (response code: #{code})"
    when 406
      raise "Can't serve any requested content type (response code: #{code})"
    when 500...600
      raise "ZOMG ERROR #{code}"
    end
end

def type_check(arg, type=String)
  raise TypeError unless arg.is_a? type
end

def test_length(input)
    if !input.is_a? NilClass and str_length(input) > 1
      raise TypeError('Parameter "source" must be either nil or length 1')
    end
end

def str_length(x)
  if x.is_a? String
    1
  else
    x.length
  end
end

# def test_values(name, input, values)
#   if input.class == String:
#     input = input.split(' ')
#   if type(input) != None:
#     if len(input) > 1: raise TypeError('Parameter "%s" must be length 1' % name)
#     if input[0] not in values: raise TypeError('Parameter "%s" must be one of %s' % (name, values))
# end

def join_ids(x)
  if x.class != NilClass
    if x.class != String
      x.join(',')
    else
      x
    end
  else
    x
  end
end

def pick_url(x)
  urls = {
      "plos" => "http://alm.plos.org/api/v5",
      "elife" => "http://lagotto.svr.elifesciences.org/api/v5",
      "crossref" => "http://det.labs.crossref.org/api/v5",
      "pkp" => "http://pkp-alm.lib.sfu.ca/api/v5",
      "copernicus" => "http://metricus.copernicus.org/api/v5",
      "pensoft" => "http://alm.pensoft.net:81//api/v5"
  }
  url = urls[x]
  if url == nil
    raise TypeError('instance must be one of plos, elife, crossref, pkp, copernicus, or pensoft')
  else
    return url
  end
end
