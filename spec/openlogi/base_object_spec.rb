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

  describe "#errors" do
    it "returns errors object with full messages" do
      object = Openlogi::BaseObject.new(errors: {
        "identifier" => ["order noを指定しない場合は、identifierを指定してください。"],
        "order_no" => ["identifierを指定しない場合は、order noを指定してください。"]
      })
      expect(object.errors.full_messages).to eq("order noを指定しない場合は、identifierを指定してください。identifierを指定しない場合は、order noを指定してください。")
    end
  end
end
