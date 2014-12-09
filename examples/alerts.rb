require 'alm'

# Get alerts data from a Lagotto instance
Alm.alerts(user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])
Alm.alerts(user: ENV["CROSSREF_ALERTS_USER"], pwd: ENV["CROSSREF_ALERTS_PWD"], instance: "crossref")
Alm.alerts(user: ENV["PKP_ALERTS_USER"], pwd: ENV["PKP_ALERTS_PWD"], instance: "pkp")

# Query for alerts
Alm.alerts(q: 'timed', user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Filter to those unresolved
Alm.alerts(unresolved: true, user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Filter by alert class name
Alm.alerts(class_name: 'EventCountIncreasingTooFastError', user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Get alerts by DOI
Alm.alerts(ids: "10.1371/journal.pone.0029797", user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Paging
Alm.alerts(per_page: 2, user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])
Alm.alerts(per_page: 2, page: 2, user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Filter by alert level (of severity)
Alm.alerts(level: "error", user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])
