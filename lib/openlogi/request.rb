module Openlogi
  class Request
    attr_reader :client, :method, :resource, :options

    def initialize(client, method, resource, options = nil)
      @client = client
      @method = method
      @resource = resource
      @options = options
    end

    def perform
      response = Typhoeus::Request.new(
        URI.join(client.endpoint, "api/", resource),
        {
          method: method,
          headers: headers
        }.merge(request_data)
      ).run

      Response.new(response)
    end

    private

    def request_data
      if method == :get
        { params: options }
      else
        { body: options.to_json }
      end
    end

    def headers
      {
        Accept: "application/json",
        'Content-Type': 'application/json',
        'X-Api-Version': "1.3",
        Authorization: "Bearer #{client.access_token}"
      }
    end
  end
end
