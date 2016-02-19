require "spec_helper"

describe Openlogi::Request do
  let(:client) { double("client", endpoint: "https://example.com", access_token: access_token) }
  let(:request) { described_class.new(client, method, "foos") }
  let(:access_token) { "token" }

  describe "#perform" do
    let(:resource) { "foos" }
    let(:response) { double("response") }

    describe "GET request" do
      let(:method) { :get }
      let!(:stub) do
        stub_request(method, "https://example.com/api/foos").
          with(headers: {
          "Authorization" => "Bearer #{access_token}",
          "Accept" => "application/json",
          "X-Api-Version" => "1.3",
          "Content-Type" => "application/json"
        })
      end

      it "creates a request" do
        request.perform
        expect(stub).to have_been_requested
      end
    end
  end
end
