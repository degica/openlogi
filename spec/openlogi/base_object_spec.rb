require "spec_helper"

class DummyObject < Openlogi::BaseObject
  property :bar
end

describe Openlogi::BaseObject do
  describe ".new" do
    it "issues warning about attributes not defined as properties on object" do
      expect_any_instance_of(DummyObject).to receive(:warn).once.with("foo is not a property of DummyObject and will be ignored.")
      object = DummyObject.new(foo: "foo", bar: "bar")
    end
  end

  describe "#valid?" do
    it "returns true if object has no error" do
      object = Openlogi::BaseObject.new(error: nil)
      expect(object.valid?).to eq(true)
    end

    it "returns false if object has an error" do
      object = Openlogi::BaseObject.new(error: "validation_failed")
      expect(object.valid?).to eq(false)
    end

    it "returns true if object has empty errors" do
      object = Openlogi::BaseObject.new(errors: {})
      expect(object.valid?).to eq(true)
    end

    it "returns true if object errors is nil" do
      object = Openlogi::BaseObject.new({})
      expect(object.valid?).to eq(true)
    end

    it "returns false if object has errors" do
      object = Openlogi::BaseObject.new(errors: { "name" => [ "Already exist" ] })
      expect(object.valid?).to eq(false)
    end
  end
end
