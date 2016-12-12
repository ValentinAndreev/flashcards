class Card < ActiveRecord::Base
  belongs_to :pack
  validates :original_text, :translated_text, :review_date, :pack, presence: true
  validate :compare
  before_validation :set_date
    
  scope :review, -> { where("review_date <= ?", Time.now.strftime('%F %H').to_datetime) }

  has_attached_file :image, styles: { medium: "360x360>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
   
  def self.randomcard
    Card.review.order("RANDOM()").first
  end
     
  def set_date
    self.review_date ||= Time.zone.now.strftime('%F %H').to_datetime
    self.wrong_checks ||= 0    
    self.right_checks ||= 0    
  end   
    
  def compare
    errors.add(:original_text, "Equal text") if self.original_text.mb_chars.downcase.to_s == self.translated_text.mb_chars.downcase.to_s
  end
end