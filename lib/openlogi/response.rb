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

    def validate!
      raise BadRequestError.new(self) if bad_request?
      raise AccessDeniedError.new(self) if access_denied?
      raise InternalServerError.new(self) if internal_server_error?
    end

    def bad_request?
      response.response_code == 400
    end

    def access_denied?
      response.response_code == 401
    end

    def internal_server_error?
      response.response_code == 500
    end

    def error
      json_response["error"]
    end

    def errors
      json_response["errors"]
    end

    def error_description
      json_response["error_description"]
    end

    private

    def json_response
      JSON.parse(response.response_body)
    end
  end
end
