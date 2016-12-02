class Pack < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  validates :title, :user, presence: true

  def self.basepack
    Pack.find_by base: true
  end
end
