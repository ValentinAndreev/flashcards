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
  
  def review_pack
    pack = packs.find_by(base: true)      
  end

  def get_card(pack_id)
    pack = packs.find_by(id: pack_id)
    card = pack.cards.randomcard if pack
  end
  
  def set_default(pack)
    packs.update_all(base: false)
    pack.update_column(:base, true)
  end

  def remove_default
    packs.update_all(base: false)
  end

  def random_all
    all_cards = Card.where("user_id = ?", id) 
    random_card = all_cards.order("RANDOM()").first if all_cards
  end

  def check(pack_id = nil)
    if !review_pack && !pack_id
      cardcheck = random_all        
    elsif review_pack
      cardcheck = get_card(review_pack.id)
    else
      cardcheck = get_card(pack_id)  
    end
  end
end