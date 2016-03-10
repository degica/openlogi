require "spec_helper"
describe Openlogi::Api::Shipments do
  let(:client) { Openlogi::Client.new }
  let(:base_url) { "https://api-demo.openlogi.com/api/shipments" }
  let(:endpoint) { described_class.new(client) }
  let(:id) { "AB001-S000001" }
  let(:status) { "waiting" }
  let(:bundled_items) { ["DQ008", "DQ009"] }
  let(:items) do
    [
      {"code"=>"DQ001", "quantity"=>1, "unit_price"=>400, "price"=>400},
      {"code"=>"DQ002", "quantity"=>2, "name"=>"つばさ", "unit_price"=>550, "price"=>1100}
    ]
  end
  let(:request_shipment) do
    {
      "id"=>id,
      "identifier"=>"2015-00001",
      "created_at"=>"2015-01-01T12:00:00+0900",
      "recipient"=> { "postcode"=>"111-0002",
        "prefecture"=>"東京都",
        "address1"=>"渋谷区渋谷1-1-1",
        "address2"=>"ラダトーム101",
        "name"=>"山田 太郎",
        "company"=>"スライム株式会社",
        "division"=>"メタル部",
        "phone"=>"03-3333-3333"
      },
      "sender"=> {
        "postcode"=>"111-0003",
        "prefecture"=>"千葉県",
        "address1"=>"浦安市舞浜1-1-1",
        "address2"=>"シンデレラ城101",
        "name"=>"ミッキー マウス",
        "company"=>"オリエンタル株式会社",
        "division"=>"ランド事業部",
        "phone"=>"03-3333-4444"
      },
      "subtotal_amount"=>1500,
      "delivery_charge"=>550,
      "handling_charge"=>0,
      "discount_amount"=>0,
      "total_amount"=>2050,
      "delivery_method"=>"HOME_BOX",
      "delivery_carrier"=>"YAMATO",
      "delivery_time_slot"=>"AM",
      "delivery_date" => "2015-01-01",
      "gift_wrapping_unit"=>"ORDER",
      "gift_wrapping_type"=>"NAVY",
      "gift_sender_name"=>"ブルー トー",
      "bundled_items" => bundled_items,
      "items"=> items
    }
  end
  let(:response_shipment) do
    request_shipment.merge("status" => status)
  end

  describe "#find" do
    let!(:stub) do
      stub_request(:get, "#{base_url}/#{id}").
        to_return(body: response_shipment.merge("status" => "shipped", "shipped_at" => "2015-01-01T15:00:00+0900").to_json)
    end
    let(:do_request) { endpoint.find(id) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      shipment = do_request

      aggregate_failures "testing response" do
        expect(shipment.id).to eq(id)
        expect(shipment.identifier).to eq("2015-00001")
        expect(shipment.created_at).to eq(DateTime.new(2015, 1, 1, 12, 0, 0, "JST"))

        # recipient
        expect(shipment.recipient.postcode).to eq("111-0002")
        expect(shipment.recipient.prefecture).to eq("東京都")
        expect(shipment.recipient.address1).to eq("渋谷区渋谷1-1-1")
        expect(shipment.recipient.address2).to eq("ラダトーム101")
        expect(shipment.recipient.name).to eq("山田 太郎")
        expect(shipment.recipient.company).to eq("スライム株式会社")
        expect(shipment.recipient.division).to eq("メタル部")
        expect(shipment.recipient.phone).to eq("03-3333-3333")

        # sender
        expect(shipment.sender.postcode).to eq("111-0003")
        expect(shipment.sender.prefecture).to eq("千葉県")
        expect(shipment.sender.address1).to eq("浦安市舞浜1-1-1")
        expect(shipment.sender.address2).to eq("シンデレラ城101")
        expect(shipment.sender.name).to eq("ミッキー マウス")
        expect(shipment.sender.company).to eq("オリエンタル株式会社")
        expect(shipment.sender.division).to eq("ランド事業部")
        expect(shipment.sender.phone).to eq("03-3333-4444")

        # totals, etc
        expect(shipment.subtotal_amount).to eq(1500)
        expect(shipment.delivery_charge).to eq(550)
        expect(shipment.handling_charge).to eq(0)
        expect(shipment.total_amount).to eq(2050)
        expect(shipment.delivery_method).to eq(:HOME_BOX)
        expect(shipment.delivery_carrier).to eq(:YAMATO)
        expect(shipment.delivery_time_slot).to eq(:AM)
        expect(shipment.delivery_date).to eq(DateTime.new(2015, 1, 1))
        expect(shipment.gift_wrapping_unit).to eq(:ORDER)
        expect(shipment.gift_wrapping_type).to eq(:NAVY)
        expect(shipment.gift_sender_name).to eq("ブルー トー")
        expect(shipment.bundled_items).to eq(["DQ008","DQ009"])
        expect(shipment.status).to eq("shipped")
        expect(shipment.shipped_at).to eq(DateTime.new(2015, 1, 1, 15, 0, 0, "JST"))

        # items
        expect(shipment.items.count).to eq(2)

        first_shipment = shipment.items.first
        expect(first_shipment.code).to eq("DQ001")
        expect(first_shipment.quantity).to eq(1)
        expect(first_shipment.unit_price).to eq(400)
        expect(first_shipment.price).to eq(400)

        second_shipment = shipment.items[1]
        expect(second_shipment.code).to eq("DQ002")
        expect(second_shipment.quantity).to eq(2)
        expect(second_shipment.name).to eq("つばさ")
        expect(second_shipment.unit_price).to eq(550)
        expect(second_shipment.price).to eq(1100)
      end
    end
  end

  describe "#all" do
    let!(:stub) do
      stub_request(:get, base_url).
        to_return(body: {"shipments" => [response_shipment] }.to_json)
    end
    let(:do_request) { endpoint.all }

    it "makes correct request "do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      shipments = do_request

      aggregate_failures "testing response" do
        expect(shipments.size).to eq(1)

        shipment = shipments.first
        expect(shipment.id).to eq(id)
        expect(shipment.recipient.postcode).to eq("111-0002")
        expect(shipment.sender.postcode).to eq("111-0003")
        expect(shipment.items.count).to eq(2)
      end
    end
  end

  describe "#update" do
    let(:bundled_items) { [] }
    let(:items) do
      [
        {
          "code" => "DQ002",
          "quantity" => 4,
          "name" => "つばさ",
          "unit_price" => 550,
          "price" => 2200
        }
      ]
    end
    let!(:stub) do
      stub_request(:put, "#{base_url}/#{id}").
        with(body: request_shipment.to_json).
        to_return(body: response_shipment.to_json)
    end
    let(:do_request) { endpoint.update(id, request_shipment) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      shipment = do_request

      expect(shipment.id).to eq(id)
      expect(shipment.bundled_items).to eq([])

      expect(shipment.items.count).to eq(1)
      shipment = shipment.items.first
      expect(shipment.code).to eq("DQ002")
      expect(shipment.quantity).to eq(4)
      expect(shipment.unit_price).to eq(550)
      expect(shipment.price).to eq(2200)
    end
  end

  describe "#create" do
    let!(:stub) do
      stub_request(:post, base_url).
        with(body: request_shipment.to_json).
        to_return(body: response_shipment.to_json)
    end
    let(:do_request) { endpoint.create(request_shipment) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      shipment = do_request

      expect(shipment.id).to eq(id)
    end

    context "with delivery options" do
      let(:delivery_options) do
        {
          "box_delivery" => 1,
          "telephone" => 0,
          "fragile_item" => 1
        }
      end
      let(:request_shipment_with_delivery_options) do
        request_shipment.merge(delivery_options: delivery_options)
      end
      let(:response_shipment_with_delivery_options) do
        request_shipment.merge(delivery_options: delivery_options)
      end
      let!(:stub) do
        stub_request(:post, base_url).
          with(body: request_shipment_with_delivery_options.to_json).
          to_return(body: response_shipment_with_delivery_options.to_json)
      end
      let(:do_request) { endpoint.create(request_shipment_with_delivery_options) }

      it "makes correct request" do
        shipment = do_request
        expect(stub).to have_been_requested

        expect(shipment.delivery_options.box_delivery).to eq(true)
        expect(shipment.delivery_options.telephone).to eq(false)
        expect(shipment.delivery_options.fragile_item).to eq(true)
      end
    end
  end

  describe "#destroy" do
    let!(:stub) do
      stub_request(:delete, "#{base_url}/#{id}").
        with(body: {}.to_json).
        to_return(body: response_shipment.to_json)
    end
    let(:do_request) { endpoint.destroy(id) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end
  end

  describe "#modify" do
    let!(:stub) do
      stub_request(:post, "#{base_url}/#{id}/modify").
        with(body: request_shipment.to_json).
        to_return(body: response_shipment.to_json)
    end
    let(:bundled_items) { [] }
    let(:items) do
      [
        {
          "code" => "DQ002",
          "quantity" => 4,
          "name" => "つばさ",
          "unit_price" => 550,
          "price" => 2200
        }
      ]
    end
    let(:do_request) { endpoint.modify(id, request_shipment) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end

    it "assigns response" do
      shipment = do_request

      expect(shipment.id).to eq(id)
      expect(shipment.bundled_items).to eq([])

      expect(shipment.items.count).to eq(1)
      shipment = shipment.items.first
      expect(shipment.code).to eq("DQ002")
    end
  end

  describe "#cancel" do
    let!(:stub) do
      stub_request(:post, "#{base_url}/#{id}/cancel").
        with(body: {}.to_json).
        to_return(body: response_shipment.to_json)
    end
    let(:do_request) { endpoint.cancel(id) }

    it "makes correct request" do
      do_request
      expect(stub).to have_been_requested
    end
  end
end
