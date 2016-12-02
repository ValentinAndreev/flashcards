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
    packs.find_by(base: true)      
  end

  def get_card(pack_id)
    pack = packs.find_by(id: pack_id)
    pack.cards.randomcard if pack
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
    all_cards.order("RANDOM()").first if all_cards
  end

  def select_card(pack_id = nil)
    if pack_id && get_card(pack_id.to_i)
      [get_card(pack_id.to_i) , I18n.t(:Training_with_choosen_pack)]
    elsif review_pack && get_card(review_pack.id) 
      [get_card(review_pack.id), I18n.t(:Training_with_base_pack)]
    else
      [random_all, I18n.t(:Training_with_random_pack)] if random_all      
    end
  end
end