require "spec_helper"

describe Openlogi::Client do
  let(:client) { Openlogi::Client.new }

  describe "#configuration" do
    it "returns a new configuration" do
      expect(client.configuration).to be_a(Openlogi::Configuration)
    end

    it "memoizes configuration" do
      configuration = client.configuration
      expect(client.configuration).to eq(configuration)
    end
  end

  describe "#configure" do
    it "configures client" do
      client.configure do |configuration|
        configuration.access_token = "mytoken"
      end

      expect(client.access_token).to eq("mytoken")
    end
  end

  describe "#endpoint" do
    it "returns test point endpoint when test mode is true" do
      client = Openlogi::Client.new
      expect(client.endpoint).to eq("https://api-demo.openlogi.com")
    end

    it "returns production endpoint when test mode is false" do
      allow(client.configuration).to receive(:test_mode).and_return(false)
      expect(client.endpoint).to eq("https://api.openlogi.com")
    end
  end

  shared_examples_for "api endpoint" do |name, klass|
    it "returns #{name} endpoint" do
      endpoint = double("endpoint")
      allow(klass).to receive(:new).with(client).and_return(endpoint)
      expect(client.public_send(name)).to eq(endpoint)
    end
  end

  describe "#items" do
    it_behaves_like "api endpoint", "items", Openlogi::Api::Items
  end

  describe "#warehousings" do
    it_behaves_like "api endpoint", "warehousings", Openlogi::Api::Warehousings
  end

  describe "#shipments" do
    it_behaves_like "api endpoint", "shipments", Openlogi::Api::Shipments
  end
end
