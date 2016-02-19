require "spec_helper"

describe Openlogi::Api::Items do
  let(:access_token) { "accesstoken" }
  let(:client) { Openlogi::Client.new(access_token) }
  let(:id) { "OS239-I000001" }
  let(:item) do
    {
      "id": id,
      "code": "testcode",
      "name": "Test Item",
      "price": 123,
      "barcode": "12345111"
    }
  end
  let(:items) { [ item ] }
  let(:endpoint) { described_class.new(client) }

  describe "#find" do
    let!(:stub) do
      stub_request(:get, "https://api-demo.openlogi.com/api/items/#{id}").
        with { |request| @request = request }.to_return(body: item.to_json)
    end
    let(:do_request) { endpoint.find(id) }

    it "returns item" do
      returned_item = do_request

      expect(stub).to have_been_requested
      expect(returned_item.code).to eq("testcode")
    end

    context "with stock" do
      let(:item) do
        {
          "id": id,
          "code": "testcode",
          "name": "Test Item",
          "stock": {
            "available": 2,
            "shipping": 1,
            "quantity": 3,
            "size": "M",
            "weight": 700
          }
        }
      end

      it "assigns stock" do
        returned_item = do_request

        expect(stub).to have_been_requested

        stock = returned_item.stock
        expect(stock.available).to eq(2)
        expect(stock.shipping).to eq(1)
        expect(stock.quantity).to eq(3)
        expect(stock.size).to eq("M")
        expect(stock.weight).to eq(700)
      end
    end
  end

  describe "#all" do
    let!(:stub) do
      stub_request(:get, "https://api-demo.openlogi.com/api/items").
        with { |request| @request = request }.to_return(body: { "items" => items }.to_json)
    end
    let(:do_request) { endpoint.all }

    it "returns items" do
      returned_items = do_request

      expect(stub).to have_been_requested
      expect(returned_items.size).to eq(1)

      returned_item = returned_items.first
      expect(returned_item.code).to eq("testcode")
      expect(returned_item.name).to eq("Test Item")
      expect(returned_item.price).to eq(123)
      expect(returned_item.barcode).to eq("12345111")
    end

    context "with stock" do
      let(:items) do
        [{
          "id": id,
          "code": "testcode",
          "name": "Test Item",
          "stock": {
            "available": 2,
            "shipping": 1,
            "quantity": 3,
            "size": "M",
            "weight": 700
          }
        }]
      end

      it "assigns stock" do
        returned_items = do_request

        expect(stub).to have_been_requested

        stock = returned_items.first.stock
        expect(stock.available).to eq(2)
        expect(stock.shipping).to eq(1)
        expect(stock.quantity).to eq(3)
        expect(stock.size).to eq("M")
        expect(stock.weight).to eq(700)
      end
    end
  end

  describe "#update" do
    let!(:stub) do
      stub_request(:put, "https://api-demo.openlogi.com/api/items/#{id}").
        with { |request| @request = request }.to_return(body: updated_item.to_json)
    end
    let(:updated_item) { item.merge(code: "newcode") }
    let(:do_request) { endpoint.update(id, { code: "newcode", name: "Test Item", price: 123 }) }

    it "updates item" do
      returned_item = do_request

      expect(stub).to have_been_requested

      expect(@request.body).to eq('{"code":"newcode","name":"Test Item","price":123}')
      expect(returned_item.code).to eq("newcode")
    end
  end

  describe "#create" do
    let!(:stub) do
      stub_request(:post, "https://api-demo.openlogi.com/api/items").
        with { |request| @request = request }.to_return(body: item.to_json)
    end
    let(:do_request) { endpoint.create(code: "testcode", name: "Test Item", price: 123, "barcode": "12345111") }

    it "creates item" do
      returned_item = do_request

      expect(stub).to have_been_requested
      expect(@request.body).to eq('{"code":"testcode","name":"Test Item","price":123,"barcode":"12345111"}')
      expect(returned_item.code).to eq("testcode")
      expect(returned_item.name).to eq("Test Item")
      expect(returned_item.price).to eq(123)
      expect(returned_item.barcode).to eq("12345111")
    end
  end

  describe "#destroy" do
    let!(:stub) do
      stub_request(:delete, "https://api-demo.openlogi.com/api/items/#{id}").
        with { |request| @request = request }.to_return(body: item.to_json)
    end
    let(:do_request) { endpoint.destroy(id) }

    it "deletes item" do
      returned_item = do_request

      expect(stub).to have_been_requested
      expect(returned_item.code).to eq("testcode")
    end
  end
end
