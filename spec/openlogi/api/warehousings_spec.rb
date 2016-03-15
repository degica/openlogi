require "spec_helper"

describe Openlogi::Api::Warehousings do
  let(:client) { Openlogi::Client.new }
  let(:base_url) { "https://api-demo.openlogi.com/api/warehousings" }
  let(:endpoint) { described_class.new(client) }
  let(:id) { "AB001-W0001" }
  let(:tracking_codes) { ["TrackingCode001", "TrackingCode002"] }
  let(:response_warehousing) do
    {
      "id" => id,
      "status" => "waiting",
      "created_at" => "2015-01-01T12:00:00+0900",
      "memo" => "やくそうは2袋に10束ずつ入っていますが、葉っぱ1枚を商品1点としてカウントしてください。",
      "tracking_codes" => tracking_codes,
      "items" => [
        {
          "id" => "AB001-I00001",
          "code" => "DQ001",
          "name" => "やくそう",
          "quantity" => 20,
        },
        {
          "id" => "AB001-I00002",
          "code" => "DQ002",
          "name" => "つばさ",
          "quantity" => 2,
        }
      ]
    }
  end

  describe "#find" do
    let!(:stub) do
      stub_request(:get, "#{base_url}/#{id}").
        to_return(body: response_warehousing.to_json)
    end
    let(:do_request) { endpoint.find(id) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      warehousing = do_request

      aggregate_failures "testing response" do
        expect(warehousing.id).to eq(id)
        expect(warehousing.status).to eq("waiting")
        expect(warehousing.created_at).to eq(DateTime.new(2015, 1, 1, 12, 0, 0, "JST"))
        expect(warehousing.memo).to eq("やくそうは2袋に10束ずつ入っていますが、葉っぱ1枚を商品1点としてカウントしてください。")
        expect(warehousing.tracking_codes).to eq(tracking_codes)
        expect(warehousing.items.count).to eq(2)
      end
    end
  end

  describe "#all" do
    let!(:stub) do
      stub_request(:get, base_url).
        to_return(body: {"warehousings" => [response_warehousing] }.to_json)
    end
    let(:do_request) { endpoint.all }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      warehousings = do_request

      aggregate_failures "testing response" do
        expect(warehousings.size).to eq(1)

        warehousing = warehousings.first
        expect(warehousing.id).to eq(id)
        expect(warehousing.status).to eq("waiting")
        expect(warehousing.created_at). to eq(DateTime.new(2015, 1, 1, 12, 0, 0, "JST"))
        expect(warehousing.memo).to eq("やくそうは2袋に10束ずつ入っていますが、葉っぱ1枚を商品1点としてカウントしてください。")
        expect(warehousing.tracking_codes).to eq(tracking_codes)

        items = warehousing.items
        expect(items.count).to eq(2)
        expect(items.first.id).to eq("AB001-I00001")
        expect(items.first.code).to eq("DQ001")
        expect(items.first.name).to eq("やくそう")
        expect(items.first.quantity).to eq(20)
      end
    end
  end

  describe "#update" do
    let!(:stub) do
      stub_request(:put, "#{base_url}/#{id}").
        with(body: '{"memo":"すごいやくそう"}').
        to_return(body: response_warehousing.merge("memo" => "すごいやくそう").to_json)
    end
    let(:do_request) { endpoint.update(id, { memo: "すごいやくそう" }) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      warehousing = do_request

      aggregate_failures "testing response" do
        expect(warehousing.memo).to eq("すごいやくそう")

        expect(warehousing.items.count).to eq(2)
        expect(warehousing.tracking_codes).to eq(tracking_codes)
      end
    end
  end

  describe "#create" do
    let!(:stub) do
      stub_request(:post, base_url).
        with(body: '{"items":[{"code":"DQ001","quantity":20},{"code":"DQ002","quantity":2}],"tracking_codes":["TrackingCode001","TrackingCode002"],"memo":"やくそうは2袋に10束ずつ入っていますが、葉っぱ1枚を商品1点としてカウントしてください。"}').
        to_return(body: '{
  "id": "AB001-W0001",
  "status": "waiting",
  "created_at": "2015-01-01T12:00:00+0900",
  "memo": "やくそうは2袋に10束ずつ入っていますが、葉っぱ1枚を商品1点としてカウントしてください。",
  "tracking_codes": [
    "TrackingCode001",
    "TrackingCode002"
  ],
  "items": [
    {
      "id": 1,
      "code": "DQ001",
      "name": "やくそう",
      "quantity": 20
    },
    {
      "id": 2,
      "code": "DQ002",
      "name": "つばさ",
      "quantity": 2
    }
  ]
}')
    end
    let(:do_request) do
      endpoint.create(
        items: [{ code: "DQ001", quantity: 20 }, { code: "DQ002", quantity: 2 } ],
        tracking_codes: [ "TrackingCode001", "TrackingCode002" ],
        memo: "やくそうは2袋に10束ずつ入っていますが、葉っぱ1枚を商品1点としてカウントしてください。")
    end

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      warehousing = do_request

      aggregate_failures "testing response" do
        expect(warehousing.id).to eq(id)
        expect(warehousing.status).to eq("waiting")
        expect(warehousing.created_at).to eq(DateTime.new(2015, 1, 1, 12, 0, 0, "JST"))
        expect(warehousing.memo).to eq("やくそうは2袋に10束ずつ入っていますが、葉っぱ1枚を商品1点としてカウントしてください。")
        expect(warehousing.tracking_codes).to eq(tracking_codes)
        expect(warehousing.items.count).to eq(2)
      end
    end
  end

  describe "#destroy" do
    let!(:stub) do
      stub_request(:delete, "#{base_url}/#{id}").
        to_return(body: response_warehousing.to_json)
    end
    let(:do_request) { endpoint.destroy(id) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      warehousing = do_request

      aggregate_failures "testing response" do
        expect(warehousing.id).to eq(id)
        expect(warehousing.status).to eq("waiting")
        expect(warehousing.created_at).to eq(DateTime.new(2015, 1, 1, 12, 0, 0, "JST"))
        expect(warehousing.tracking_codes).to eq(tracking_codes)
        expect(warehousing.items.count).to eq(2)
      end
    end
  end
end
