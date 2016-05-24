class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable,
         authentication_keys: { username: true, email: false }

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
