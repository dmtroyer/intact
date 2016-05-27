class HashedString < ActiveRecord::Base
  include Hashable

  belongs_to :user
  validates :original, presence: { message: "string can't be blank" }
end
