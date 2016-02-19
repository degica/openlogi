require "spec_helper"

describe Openlogi::Api::Warehousings do
  let(:access_token) { "accesstoken" }
  let(:client) { Openlogi::Client.new(access_token) }
  let(:id) { "AB001-W000" }
  let(:warehousing) do
    {
      "id": id,
      "status": "waiting",
      "memo": "Test memo",
      "tracking_codes": tracking_codes,
      "items": items
    }
  end
  let(:tracking_codes) do
    [ "TrackingCode001", "TrackingCode002" ]
  end
  let(:items) { [ item ] }
  let(:item) do
    {
      "id": "AB001-I00001",
      "code": "DQ001",
      "name": "やくそう",
      "quantity": 20
    }
  end
  let(:warehousings) { [ warehousing ] }
  let(:endpoint) { described_class.new(client) }

  describe "#find" do
    let!(:stub) do
      stub_request(:get, "https://api-demo.openlogi.com/api/warehousings/#{id}").
        with { |request| @request = request }.to_return(body: warehousing.to_json)
    end
    let(:do_request) { endpoint.find(id) }

    it "returns warehousing" do
      returned_warehousing = do_request

      expect(stub).to have_been_requested
      expect(returned_warehousing.id).to eq(id)
    end
  end

  describe "#all" do
    let!(:stub) do
      stub_request(:get, "https://api-demo.openlogi.com/api/warehousings").
        with { |request| @request = request }.to_return(body: { "warehousings" => warehousings }.to_json)
    end
    let(:do_request) { endpoint.all }

    it "returns warehousings" do
      returned_warehousings = do_request

      expect(stub).to have_been_requested
      expect(returned_warehousings.size).to eq(1)

      returned_warehousing = returned_warehousings.first
      expect(returned_warehousing.id).to eq(id)
      expect(returned_warehousing.status).to eq("waiting")
      expect(returned_warehousing.memo).to eq("Test memo")
      expect(returned_warehousing.tracking_codes).to eq(["TrackingCode001", "TrackingCode002"])

      items = returned_warehousing.items
      expect(items.count).to eq(1)
      expect(items.first.id).to eq("AB001-I00001")
      expect(items.first.code).to eq("DQ001")
      expect(items.first.name).to eq("やくそう")
      expect(items.first.quantity).to eq(20)
    end
  end

  describe "#update" do
    let!(:stub) do
      stub_request(:put, "https://api-demo.openlogi.com/api/warehousings/#{id}").
        with { |request| @request = request }.to_return(body: updated_warehousing.to_json)
    end
    let(:updated_warehousing) { warehousing.merge(memo: "newmemo") }
    let(:do_request) { endpoint.update(id, { memo: "newmemo", tracking_codes: tracking_codes, items: items }) }

    it "updates warehousing" do
      returned_warehousing = do_request

      expect(stub).to have_been_requested

      expect(@request.body).to eq("{\"memo\":\"newmemo\",\"tracking_codes\":#{tracking_codes.to_json},\"items\":#{items.to_json}}")
      expect(returned_warehousing.memo).to eq("newmemo")

      expect(returned_warehousing.items.count).to eq(1)
      expect(returned_warehousing.tracking_codes.count).to eq(2)
    end
  end

  describe "#create" do
    let!(:stub) do
      stub_request(:post, "https://api-demo.openlogi.com/api/warehousings").
        with { |request| @request = request }.to_return(body: warehousing.to_json)
    end
    let(:do_request) { endpoint.create(items: { code: "foo", quantity: 1 }) }

    it "creates warehousing" do
      returned_warehousing = do_request

      expect(stub).to have_been_requested
      expect(@request.body).to eq('{"items":{"code":"foo","quantity":1}}')
      expect(returned_warehousing.items.count).to eq(1)
    end
  end

  describe "#destroy" do
    let!(:stub) do
      stub_request(:delete, "https://api-demo.openlogi.com/api/warehousings/#{id}").
        with { |request| @request = request }.to_return(body: warehousing.to_json)
    end
    let(:do_request) { endpoint.destroy(id) }

    it "deletes warehousing" do
      returned_warehousing = do_request

      expect(stub).to have_been_requested
      expect(returned_warehousing.memo).to eq("Test memo")
    end
  end
end
