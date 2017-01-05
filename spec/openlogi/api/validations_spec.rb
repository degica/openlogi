require "spec_helper"

describe Openlogi::Api::Validations do
  let(:client) { Openlogi::Client.new }
  let(:base_url) { "https://api-demo.openlogi.com/api/validations" }
  let(:endpoint) { described_class.new(client) }

  shared_examples_for "validations api" do |name|
    context "when valid response" do
      let(:params) do
        {
          postcode: "1700014",
          prefecture: "東京都",
          address1: "豊島区池袋1-1-7",
          address2: "第2伊三美ビル8F",
          phone: "09000000000",
          name: "大分路地男"
        }
      end
      let!(:stub) do
        stub_request(:post, "#{base_url}/#{name}").
          to_return(body: '
{
  "postcode": "1700014",
  "prefecture": "東京都",
  "address1": "豊島区池袋1-1-7",
  "address2": "第2伊三美ビル8F",
  "phone": "09000000000",
  "name": "大分路地男"
}')
      end
      let(:do_request) { endpoint.send(name, params) }

      it "makes correct request" do
        do_request
        expect(stub).to have_been_requested
      end

      it "assigns response" do
        validation = do_request

        aggregate_failures "testing response" do
          expect(validation.success).to eq(true)
          expect(validation.error).to eq(nil)
          expect(validation.errors).to eq(nil)
          expect(validation.error_description).to eq(nil)
        end
      end
    end

    context "when invalid response" do
      let!(:stub) do
        stub_request(:post, "#{base_url}/#{name}").
          to_return(status: 422, body: %Q{
{
  "error": "invalid_request",
  "error_description": "Invalid Request",
  "errors": {
    "#{name}.postcode": ["#{name}.postcodeは必ず指定してください。"],
    "#{name}.prefecture": ["#{name}.prefectureは必ず指定してください。"],
    "#{name}.address1": ["#{name}.address1は必ず指定してください。"],
    "#{name}.name": ["#{name}.nameは必ず指定してください。"],
    "#{name}.phone": ["#{name}.phoneは必ず指定してください。"]
  }
}})
      end
      let(:do_request) { endpoint.send(name, {}) }

      it "makes correct request" do
        do_request
        expect(stub).to have_been_requested
      end

      it "assigns response" do
        validation = do_request

        aggregate_failures "testing response" do
          expect(validation.success).to eq(false)
          expect(validation.error).to eq("invalid_request")
          expect(validation.errors).to eq({
            "#{name}.postcode"   => ["#{name}.postcodeは必ず指定してください。"],
            "#{name}.prefecture" => ["#{name}.prefectureは必ず指定してください。"],
            "#{name}.address1"   => ["#{name}.address1は必ず指定してください。"],
            "#{name}.name"       => ["#{name}.nameは必ず指定してください。"],
            "#{name}.phone"      => ["#{name}.phoneは必ず指定してください。"]
          })
          expect(validation.error_description).to eq("Invalid Request")
        end
      end
    end
  end

  describe "#recipient" do
    it_behaves_like "validations api", "recipient"
  end

  describe "#sender" do
    it_behaves_like "validations api", "sender"
  end
end
