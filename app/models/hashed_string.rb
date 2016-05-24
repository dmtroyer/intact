class HashedString < ActiveRecord::Base
  belongs_to :user
  validates :original, presence: true
end
