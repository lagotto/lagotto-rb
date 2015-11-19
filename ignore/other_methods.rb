  ##
  # Make a `/requests` route request
  #
  # @!macro lagotto_params
  # @!macro lagotto_options
  # @return [Hash] A hash
  #
  # @example:
  #      require 'lagotto-rb'
  #      Lagotto.requests(key: ENV['PLOS_API_KEY'])
  def self.requests(key: nil, instance: 'plos', options: nil, verbose: false)
    url = pick_url(instance)
    BasicRequest.new(url, 'api_requests', key, options, verbose).perform
    # options = {
    #   query: {
    #     api_key: key
    #   },
    #   headers: {"Accept" => 'application/json'}
    # }
    # res = HTTParty.get(url+'/api_requests', options)
    # response_ok(res.code)
    # return res
  end
