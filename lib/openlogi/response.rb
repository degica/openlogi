module Openlogi
  class Response
    include Enumerable

    attr_reader :response
    delegate :success?, to: :response
    delegate :each, :fetch, to: :json_response

    def initialize(response)
      @response = response
    end

    private

    def json_response
      JSON.parse(response.response_body)
    end
  end
end
