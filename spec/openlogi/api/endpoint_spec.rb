require "spec_helper"

describe Openlogi::Api::Endpoint do

  describe "#perform_request" do
    let(:client) { Openlogi::Client.new(access_token: "foo") }
    let(:options) { double("options") }
    let(:request) { double("request", perform: response) }
    let(:endpoint) { Openlogi::Api::Endpoint.new(client) }

    context "response is valid" do
      let(:response) { double("response", invalid?: false) }

      it "performs a request" do
        expect(Openlogi::Request).to receive(:new).once.with(client, "method", "resource", options).and_return(request)
        endpoint.perform_request("method", "resource", options)
      end

      it "assigns response to client.last_response" do
        allow(Openlogi::Request).to receive(:new).and_return(request)
        endpoint.perform_request("method", "resource", options)

        expect(client.last_response).to eq(response)
      end
    end

    context "response is invalid" do
      let(:response) { double("response", invalid?: true, error_description: "foo error") }

      it "raises InvalidResponseError" do
        allow(Openlogi::Request).to receive(:new).and_return(request)
        expect {
          endpoint.perform_request("method", "resource", options)
        }.to raise_error(Openlogi::InvalidResponseError, "foo error")
      end
    end
  end
end
