require 'alm'

Lagotto.status(key: ENV['CROSSREF_API_KEY'], instance: "crossref")
Lagotto.status(key: ENV['PLOS_API_KEY'])
Lagotto.status(key: ENV['PKP_API_KEY'], instance: "pkp")
