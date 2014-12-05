require 'httparty'
require 'json'

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

module Alm
 	##
	# Get a single citation in various formats from a DOI
	#
	# Args:
	# * doi: A DOI
	# * format: one of rdf-xml, turtle, citeproc-json, text, ris, bibtex, crossref-xml,
	# * style: Only used if format='text', e.g., apa, harvard3
	# * locale: A locale, e.g., en-US
	# * cache: Should cache be used
	# 	* true: Try fetcing from cache and store to cache (default)
	#   * false: Do use cache at all
	#   * 'flush': Get a fresh response and cache it
	#
	# alm('10.1371%252Fjournal.pone.0025110', api_key='rkfDr76z75benY3pytM1')

	def self.alm(ids=nil, type=nil, info=nil,
            source=nil, publisher=nil, order=nil, per_page=nil,
            page=nil, instance='plos', key=nil, options = {})

		test_length(source)
	    type_check(page, Fixnum)
	    type_check(per_page, Fixnum)
	    # test_values('info', info, ['summary','detail'])
	    # test_values('id_type', id_type, ['doi','pmid','pmcid','mendeley_uuid'])
	    # test_values('instance', instance, ['plos','crossref','copernicus','elife','pensoft','pkp'])

		url = urls[instance]
		headers = {"Accept" => 'application/json'}
		args = {"ids" => ids, "info" => info, "api_key" => key}
	    response = HTTParty.get("http://alm.plos.org/api/v5/articles", :query => args, :headers => headers)

	    if response_ok(response.code)
	    	content = response.body
	    end

		return content
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

urls = {
	"plos" => "http://alm.plos.org/api/v5/articles",
	"elife" => "http://lagotto.svr.elifesciences.org/api/v5/articles",
	"crossref" => "http://det.labs.crossref.org/api/v5/articles",
	"pkp" => "http://pkp-alm.lib.sfu.ca/api/v5/articles",
	"copernicus" => "http://metricus.copernicus.org/api/v5/articles",
	"pensoft" => "http://alm.pensoft.net:81//api/v5/articles"
}
