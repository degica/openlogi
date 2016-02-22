require "spec_helper"

describe Openlogi::Api::Items do
  let(:access_token) { "accesstoken" }
  let(:client) { Openlogi::Client.new(access_token) }
  let(:base_url) { "https://api-demo.openlogi.com/api/items" }
  let(:endpoint) { described_class.new(client) }

  describe "#find" do
    let(:id) { "AB001-I000001" }
    let!(:stub) do
      stub_request(:get, "#{base_url}/#{id}").
        to_return(body: '
{
  "id": "AB001-I000001",
  "code": "DQ001",
  "name": "やくそう",
  "stock": {
    "available": 2,
    "shipping": 1,
    "quantity": 3,
    "size": "M",
    "weight": 700
  }
}')
    end
    let(:do_request) { endpoint.find(id) }

    it "returns item" do
      returned_item = do_request

      expect(stub).to have_been_requested
      expect(returned_item.id).to eq(id)
      expect(returned_item.code).to eq("DQ001")
      expect(returned_item.name).to eq("やくそう")
      expect(returned_item.stock.available).to eq(2)
      expect(returned_item.stock.shipping).to eq(1)
      expect(returned_item.stock.quantity).to eq(3)
      expect(returned_item.stock.size).to eq("M")
      expect(returned_item.stock.weight).to eq(700)
    end
  end

  describe "#all" do
    let!(:stub) do
      stub_request(:get, base_url).
        to_return(body: '
{
  "items": [
    {
      "id": "AB001-I000001",
      "code": "DQ001",
      "name": "やくそう",
      "stock": {
        "available": 2,
        "shipping": 1,
        "quantity": 3,
        "size": "M",
        "weight": 700
      }
    },
    {
      "id": "AB001-I000002",
      "code": "DQ002",
      "name": "キメラのつばさ"
    }
  ]
}')
    end
    let(:do_request) { endpoint.all }

    it "returns items" do
      returned_items = do_request

      expect(stub).to have_been_requested
      expect(returned_items.size).to eq(2)

      first_item = returned_items.first
      expect(first_item.id).to eq("AB001-I000001")
      expect(first_item.code).to eq("DQ001")
      expect(first_item.name).to eq("やくそう")

      expect(first_item.stock.available).to eq(2)
      expect(first_item.stock.shipping).to eq(1)
      expect(first_item.stock.quantity).to eq(3)
      expect(first_item.stock.size).to eq("M")
      expect(first_item.stock.weight).to eq(700)

      second_item = returned_items.last
      expect(second_item.id).to eq("AB001-I000002")
      expect(second_item.code).to eq("DQ002")
      expect(second_item.name).to eq("キメラのつばさ")
    end
  end

  describe "#update" do
    let(:id) { "AB001-I000001" }
    let!(:stub) do
      stub_request(:put, "#{base_url}/#{id}").
        with(body: '{"name":"すごいやくそう"}').
        to_return(body: '
{
  "id": "AB001-I000001",
  "code": "DQ001",
  "name": "すごいやくそう"
}')
    end
    let(:do_request) { endpoint.update(id, { name: "すごいやくそう" }) }

    it "updates item" do
      returned_item = do_request

      expect(stub).to have_been_requested

      expect(returned_item.id).to eq(id)
      expect(returned_item.code).to eq("DQ001")
      expect(returned_item.name).to eq("すごいやくそう")
    end
  end

  describe "#create" do
    let!(:stub) do
      stub_request(:post, base_url).
        with(body: '{"code":"DQ003","name":"世界樹の葉","international_info":{"invoice_summary":"MAGICAL LEAF"}}').
        to_return(body: '
{
  "id": "AB001-I000003",
  "code": "DQ003",
  "name": "世界樹の葉",
  "international_info": {
    "invoice_summary": "MAGICAL LEAF"
  }
}')
    end
    let(:do_request) { endpoint.create(code: "DQ003", name: "世界樹の葉", international_info: { invoice_summary: "MAGICAL LEAF" }) }

    it "creates item" do
      returned_item = do_request

      expect(stub).to have_been_requested
      expect(returned_item.id).to eq("AB001-I000003")
      expect(returned_item.code).to eq("DQ003")
      expect(returned_item.id).to eq("AB001-I000003")
      expect(returned_item.name).to eq("世界樹の葉")
      expect(returned_item.international_info.invoice_summary).to eq("MAGICAL LEAF")
    end
  end

  describe "#destroy" do
    let(:id) { "AB001-I000001" }
    let!(:stub) do
      stub_request(:delete, "#{base_url}/#{id}").
        with(body: {}.to_json).
        to_return(body: '{"id":"AB001-I000001","code":"DQ001","name":"すごいやくそう"}')
    end
    let(:do_request) { endpoint.destroy(id) }

    it "deletes item" do
      returned_item = do_request

      expect(stub).to have_been_requested
      expect(returned_item.id).to eq(id)
      expect(returned_item.code).to eq("DQ001")
      expect(returned_item.name).to eq("すごいやくそう")
    end
  end
end
