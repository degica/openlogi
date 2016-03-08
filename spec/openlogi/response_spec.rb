require "spec_helper"

describe Openlogi::Response do

  describe "#bad_request?" do
    it "returns true if response code is 400" do
      http_response = double("response", response_code: 400)
      response = Openlogi::Response.new(http_response)
      expect(response.bad_request?).to eq(true)
    end

    it "returns false if response code is not 400" do
      http_response = double("response", response_code: 200)
      response = Openlogi::Response.new(http_response)
      expect(response.bad_request?).to eq(false)
    end
  end

  describe "#validate!" do
    context "response is success" do
      it "does nothing" do
        response = Openlogi::Response.new(double("response", response_code: 200))
        expect { response.validate! }.not_to raise_error
      end
    end

    context "response is a bad request" do
      it "raises BadRequestError" do
        response = Openlogi::Response.new(double("response", response_code: 400, response_body: "\{\"error_description\":\"foo\"\}"))
        expect { response.validate! }.to raise_error(Openlogi::BadRequestError, "foo")
      end
    end

    context "response is a server error" do
      it "raises InternalServerError" do
        response = Openlogi::Response.new(double("response", response_code: 500, response_body: "\{\"error_description\":\"foo\"\}"))
        expect { response.validate! }.to raise_error(Openlogi::InternalServerError, "foo")
      end
    end
  end

  describe "#error" do
    it "returns error from json response" do
      http_response = double("response", response_body: "\{\"error\":\"foo error\"\}")
      response = Openlogi::Response.new(http_response)
      expect(response.error).to eq("foo error")
    end
  end

  describe "#error_description" do
    it "returns error_description from json response" do
      http_response = double("response", response_body: "\{\"error_description\":\"foo description\"\}")
      response = Openlogi::Response.new(http_response)
      expect(response.error_description).to eq("foo description")
    end
  end
end
