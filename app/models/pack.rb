class Pack < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  validates :title, :user, presence: true  
end