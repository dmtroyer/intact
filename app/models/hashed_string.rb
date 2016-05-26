class HashedString < ActiveRecord::Base
  include Hashable

  belongs_to :user
  validates :original, presence: true
end
