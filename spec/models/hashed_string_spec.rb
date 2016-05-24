require 'rails_helper'

RSpec.describe HashedString, type: :model do
  context "validation" do
    it "requires an original string" do
      string = HashedString.new
      expect(string).to_not be_valid
    end
  end
end
