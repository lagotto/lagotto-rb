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
	def self.alm(doi, )
		if format == 'text'
			type = "#{formatuse}; style=#{style}; locale=#{locale}"
		else
			type = formatuse
		end
		doi = 'http://dx.doi.org/' + doi

		if cache == true or cache == 'flush'
			if cache == true
				cache_time = 6000
				msg = "Requested DOI not in cache or is stale, requesting..."
			elsif cache == 'flush'
				cache_time = 1
				msg = "Flushing cache, requesting..."
			end

			content = APICache.get(cache_key, :cache => cache_time,
								   :valid => :forever, :period => 0,
								   :timeout => 30) do
			    puts msg
			    response = HTTParty.get(doi, :headers => {"Accept" => type})

			    # If response code is ok (200) get response body and return
			    # that from this block. Otherwise an error will be raised.
			   	begin
				    if response_ok(response.code)
				    	content = response.body
				    end
					content
				rescue Exception => e
					puts e.message
					puts "Format requested: #{formatuse}"
					exit
				end
			end
		elsif cache == false
			puts "Not using cache, requesting..."
			response = HTTParty.get(doi, :headers => {"Accept" => type})

			if response_ok(response.code)
			    content = response.body
			end
		else
			fail "Invalid cache value #{cache}"
		end
		# response = HTTParty.get(doi, :headers => {"Accept" => type})
		if format == 'bibtex'
			output = BibTeX.parse(content).to_s
		else
			output = content
		end
		# output.display
		return output
	end

end
