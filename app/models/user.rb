class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: { case_sensitive: false }
  validates :password,  presence: true, length: { in: 6..20 }  
end
