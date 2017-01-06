# User
class User < ActiveRecord::Base 
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :packs, dependent: :destroy
  has_many :cards, through: :packs
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :locale, presence: true, inclusion: { in: proc { I18n.available_locales.map { |x| x.to_s } } }

  validates :email, presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
    uniqueness: { case_sensitive: false }

  def self.send_email
    CardsMailer.pending_cards_notification(notifications_list).deliver_now if notifications_list
  end

  def self.notifications_list
    cards = Card.review.pluck(:user_id).uniq
    User.where(id: cards).pluck(:email)
  end

  def review_pack
    packs.find_by(base: true)
  end

  def default_cards
    review_pack.cards.randomcard if review_pack
  end

  def default(pack)
    remove_default
    pack.update_column(:base, true)
  end

  def remove_default
    packs.update_all(base: false)
  end

  def select_card
    @card = default_cards
    @card ? [@card, I18n.t(:Training_with_base_pack)] : [cards.randomcard, I18n.t(:Training_with_random_pack)]
  end
end
