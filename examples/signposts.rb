require 'alm'
require 'httparty'

# Get altmetrics by DOI
## swap out the key and instance to change provider
Lagotto.signposts(ids: '10.1371/journal.pone.0029797', instance: "crossref")
dois = ['10.1371/journal.pone.0061981','10.1371/journal.pmed.0020124','10.1371/journal.pbio.1001535']
Lagotto.signposts(ids: dois)
Lagotto.signposts(ids: '10.4081/audiores.2013.e1', instance: "pkp")
Lagotto.signposts(ids: '10.1371/journal.pone.0025110', instance: "plos")
ids = ["10.1371/journal.pone.0029797","10.1371/journal.pone.0029798"]
Lagotto.signposts(ids: ids, instance: "plos")

# Search by source
Lagotto.signposts(source: 'twitter', instance: "crossref")
Lagotto.signposts(instance: "crossref", per_page: 5)

# Get data by publisher
ids = HTTParty.get("http://api.crossref.org/members")
ids = ids['message']['items'].collect { |p| p['id'] }
Lagotto.signposts(publisher: ids[0], info: "summary")
