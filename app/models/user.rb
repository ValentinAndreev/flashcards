class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :packs, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: { case_sensitive: false }
  
  def review_pack(pack_id = nil)
    unless pack_id 
      pack = packs.find_by(base: true)      
    else
      pack = packs.find_by(id: pack_id)
    end
  end

  def get_card(pack_id = nil)
    pack = review_pack(pack_id)
    pack = pack.cards.randomcard if pack
  end
  
  def set_default(pack_id)
    old_pack = packs.find_by(base: true)  
    if old_pack
      old_pack.base = false 
      old_pack.save
    end
    new_pack = packs.find_by(id: pack_id)
    new_pack.base = true
    new_pack.save
  end

  def random_all
    all_cards = Card.where("user_id = ?", id) 
    random_card = all_cards.order("RANDOM()").first if all_cards
  end
end