require 'alm'

Alm.requests(key: ENV['CROSSREF_API_KEY'], instance: "crossref")
Alm.requests(key: ENV['PLOS_API_KEY'])
Alm.requests(key: ENV['PKP_API_KEY'], instance: "pkp")
