require 'alm'
require 'httparty'

# Get events by DOI
## swap out the key and instance to change provider
Lagotto.events(ids: '10.1371/journal.pone.0029797', instance: "crossref")
Lagotto.events(ids: ['10.1371/journal.pone.0029797','10.1016/j.dsr2.2010.10.029'], instance: "crossref")
Lagotto.events(ids: '10.4081/audiores.2013.e1', instance: "pkp")
Lagotto.events(ids: "10.1371/journal.pone.0029797")
ids = ["10.1371/journal.pone.0029797","10.1371/journal.pone.0029798"]
Lagotto.events(ids: ids)

# Search by source
Lagotto.events(source: 'twitter', instance: "crossref")
Lagotto.events(instance: "crossref", per_page: 5)

# Get data by publisher
ids = HTTParty.get("http://api.crossref.org/members")
ids = ids['message']['items'].collect { |p| p['id'] }
Lagotto.events(publisher: ids[0], info: "summary")
