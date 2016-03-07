require "spec_helper"

describe Openlogi::Response do

  describe "#invalid?" do
    it "returns true if response has request_invalid error" do
      http_response = double("response", response_body: "\{\"error\":\"invalid_request\"\}")
      response = Openlogi::Response.new(http_response)
      expect(response.invalid?).to eq(true)
    end

    it "returns false if response does not have request_invalid error" do
      http_response = double("response", response_body: "\{\"error\":\"foo\"\}")
      response = Openlogi::Response.new(http_response)
      expect(response.invalid?).to eq(false)

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
