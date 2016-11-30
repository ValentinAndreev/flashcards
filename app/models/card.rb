class Card < ActiveRecord::Base
  belongs_to :user
  validates :original_text, :translated_text, :review_date, :user, presence: true
  validate :compare
  before_validation :set_date
    
  scope :review, -> { where(review_date: Date.today) }

  has_attached_file :image, styles: { medium: "360x360>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
   
  def self.randomcard
    Card.review.order("RANDOM()").first
  end
     
  def set_date
    self.review_date ||= Date.today
  end    
    
 def compare
   errors.add(:original_text, "Equal text") if self.original_text.mb_chars.downcase.to_s == self.translated_text.mb_chars.downcase.to_s
 end
end
