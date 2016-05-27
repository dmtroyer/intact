require 'rails_helper'

RSpec.describe HashedString, type: :model do
  context "validation" do
    it "has a valid factory" do
      string = build(:hashed_string)
      expect(string).to be_valid
    end

    it "requires an original string" do
      string = build(:hashed_string, original: nil)
      expect(string).to_not be_valid
      string.original = 'falafel'
      expect(string).to be_valid
    end

    it "retrieves the hashed value on save" do
      stub_iron_worker_calls
      string = create(:hashed_string)
      expect(string.hashed).to eql("309f09jads09ds")
    end
  end
end
