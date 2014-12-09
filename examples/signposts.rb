require 'alm'
require 'httparty'

# Get altmetrics by DOI
## swap out the key and instance to change provider
Alm.signposts(ids: '10.1371/journal.pone.0029797', key: ENV['CROSSREF_API_KEY'], instance: "crossref")
dois = ['10.1371/journal.pone.0061981','10.1371/journal.pmed.0020124','10.1371/journal.pbio.1001535']
Alm.signposts(ids: dois, key: ENV['PLOS_API_KEY'])
Alm.signposts(ids: '10.4081/audiores.2013.e1', key: ENV['PKP_API_KEY'], instance: "pkp")
Alm.signposts(ids: '10.1371/journal.pone.0025110', key: ENV['PLOS_API_KEY'], instance: "plos")
ids = ["10.1371/journal.pone.0029797","10.1371/journal.pone.0029798"]
Alm.signposts(ids: ids, key: ENV['PLOS_API_KEY'], instance: "plos")

# Search by source
Alm.signposts(source: 'twitter', key: ENV['CROSSREF_API_KEY'], instance: "crossref")
Alm.signposts(instance: "crossref", per_page: 5, key: ENV['CROSSREF_API_KEY'])

# Get data by publisher
ids = HTTParty.get("http://api.crossref.org/members")
ids = ids['message']['items'].collect { |p| p['id'] }
Alm.signposts(publisher: ids[0], info: "summary")
