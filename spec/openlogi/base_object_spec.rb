require "spec_helper"

describe Openlogi::BaseObject do
  describe "#valid?" do
    it "returns true if object has no errors" do
      object = Openlogi::BaseObject.new(errors: {})
      expect(object.valid?).to eq(true)
    end

    it "returns false if object has errors" do
      object = Openlogi::BaseObject.new(errors: { "name" => [ "Already exist" ] })
      expect(object.valid?).to eq(false)
    end
  end
end
