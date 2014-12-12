require 'alm'
require 'httparty'

# Get events by DOI
## swap out the key and instance to change provider
Alm.events(ids: '10.1371/journal.pone.0029797', key: ENV['CROSSREF_API_KEY'], instance: "crossref")
Alm.events(ids: ['10.1371/journal.pone.0029797','10.1016/j.dsr2.2010.10.029'], key: ENV['CROSSREF_API_KEY'], instance: "crossref")
Alm.events(ids: '10.4081/audiores.2013.e1', key: ENV['PKP_API_KEY'], instance: "pkp")
Alm.events(ids: "10.1371/journal.pone.0029797", key: ENV['PLOS_API_KEY'])
ids = ["10.1371/journal.pone.0029797","10.1371/journal.pone.0029798"]
Alm.events(ids: ids, key: ENV['PLOS_API_KEY'])

# Search by source
Alm.events(source: 'twitter', key: ENV['CROSSREF_API_KEY'], instance: "crossref")
Alm.events(instance: "crossref", per_page: 5, key: ENV['CROSSREF_API_KEY'])

# Get data by publisher
ids = HTTParty.get("http://api.crossref.org/members")
ids = ids['message']['items'].collect { |p| p['id'] }
Alm.events(publisher: ids[0], info: "summary")
