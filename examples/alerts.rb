require 'alm'

# Get alerts data from a Lagotto instance
Lagotto.alerts(user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])
Lagotto.alerts(user: ENV["CROSSREF_ALERTS_USER"], pwd: ENV["CROSSREF_ALERTS_PWD"], instance: "crossref")
Lagotto.alerts(user: ENV["PKP_ALERTS_USER"], pwd: ENV["PKP_ALERTS_PWD"], instance: "pkp")

# Query for alerts
Lagotto.alerts(q: 'timed', user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Filter to those unresolved
Lagotto.alerts(unresolved: true, user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Filter by alert class name
Lagotto.alerts(class_name: 'EventCountIncreasingTooFastError', user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Get alerts by DOI
Lagotto.alerts(ids: "10.1371/journal.pone.0029797", user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Paging
Lagotto.alerts(per_page: 2, user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])
Lagotto.alerts(per_page: 2, page: 2, user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])

# Filter by alert level (of severity)
Lagotto.alerts(level: "error", user: ENV["PLOS_ALERTS_USER"], pwd: ENV["PLOS_ALERTS_PWD"])
