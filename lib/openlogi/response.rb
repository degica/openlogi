module Openlogi
  class Response
    include Enumerable
    extend Forwardable

    attr_reader :response
    def_delegator :response, :success?
    def_delegators :json_response, :each, :each_pair, :each_key, :fetch, :to_hash

    def initialize(response)
      @response = response
    end

    private

    def json_response
      JSON.parse(response.response_body)
    end
  end
end
