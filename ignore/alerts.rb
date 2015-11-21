  def self.alerts(source: nil, ids: nil, class_name: nil, level: nil, q: nil,
    unresolved: nil, per_page: 50, page: 1, user: nil, pwd: nil,
    instance: 'plos', options: {})

    url = pick_url_alerts(instance)
    # userpwd = getuserinfo(user, pwd)
    options = {
      query: {
        q: q,
        class_name: class_name,
        source: source,
        level: level,
        unresolved: unresolved,
        ids: ids,
        rows: per_page,
        page: page
      },
      basic_auth: { username: user, password: pwd }
    }
    options[:query] = options[:query].reject{ |i,j| j == nil }
    res = HTTParty.get(url, options)
    response_ok(res.code)
    return res
  end
