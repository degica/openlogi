require "spec_helper"

describe Openlogi::Api::Endpoint do

  describe "#perform_request" do
    let(:client) { Openlogi::Client.new(access_token: "foo") }
    let(:options) { double("options") }
    let(:request) { double("request", perform: response) }
    let(:endpoint) { Openlogi::Api::Endpoint.new(client) }

    context "response is ok" do
      let(:response) { Openlogi::Response.new(double("response", response_code: 200)) }

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
      let(:response) { Openlogi::Response.new(double("response", response_code: 400, response_body: "\{\"error_description\":\"foo\"\}")) }
      before do
        allow(Openlogi::Request).to receive(:new).and_return(request)
      end

      it "raises BadRequestError" do
        expect {
          endpoint.perform_request("method", "resource", options)
        }.to raise_error(Openlogi::BadRequestError, "foo")
      end

      it "assigns response to client.last_response" do
        begin
          endpoint.perform_request("method", "resource", options)
        rescue Openlogi::BadRequestError
        end

        expect(client.last_response).to eq(response)
      end
    end

    describe "delegators" do
      let(:endpoint) { Openlogi::Api::Endpoint.new(double("client")) }

      it "delegates iterator methods to all with arguments" do
        expect(endpoint).to receive(:all).with(stock: true).and_return(["first"])
        expect(endpoint.first(stock: true)).to eq("first")
      end

      it "delegates iterator methods to all without arguments" do
        expect(endpoint).to receive(:all).with(no_args).and_return(["first"])
        expect(endpoint.first).to eq("first")
      end
    end
  end
end
