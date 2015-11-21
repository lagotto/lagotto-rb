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
    "plos" => "http://alm.plos.org/api",
    "crossref" => "http://det.labs.crossref.org/api",
    "datacite" => "http://dlm.datacite.org/api",
    "datacite_profiles" => "https://profiles.labs.datacite.org/api",
    "elife" => "http://alm.svr.elifesciences.org/api/v5",
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

def getuserinfo(x: nil, y: nil)
  usr = ifnot(x, ENV["PLOS_ALERTS_USER"])
  pwd = ifnot(y, ENV["PLOS_ALERTS_PWD"])
  return { "key" => usr, "pwd" => pwd }
end

def ifnot(x, y)
  if x == nil
    return y
  else
    return x
  end
end

def pick_url_alerts(x)
  urls = {
    "plos" => "http://alm.plos.org/api/alerts",
    "elife" => "http://lagotto.svr.elifesciences.org/api/v4/alerts",
    "crossref" => "http://det.labs.crossref.org/api/v4/alerts",
    "pkp" => "http://pkp-alm.lib.sfu.ca/api/v4/alerts",
    "copernicus" => "http://metricus.copernicus.org/api/v4/alerts",
    "pensoft" => "http://alm.pensoft.net:81//api/v4/alerts"
  }
  url = urls[x]
  if url == nil
    raise TypeError('instance must be one of plos, elife, crossref, pkp, copernicus, or pensoft')
  else
    return url
  end
end
