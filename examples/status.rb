require 'alm'

Alm.status(key: ENV['CROSSREF_API_KEY'], instance: "crossref")
Alm.status(key: ENV['PLOS_API_KEY'])
Alm.status(key: ENV['PKP_API_KEY'], instance: "pkp")
