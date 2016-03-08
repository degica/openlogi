require "spec_helper"

describe Openlogi::BaseObject do
  describe ".new" do
    it "issues warning about attributes not defined as properties on object" do
      expect_any_instance_of(Openlogi::BaseObject).to receive(:warn).once.with("foo is not a property of Openlogi::BaseObject and will be ignored.")
      object = Openlogi::BaseObject.new(foo: "bar")
    end
  end

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
