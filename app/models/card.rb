require 'dotenv'

class Card < ActiveRecord::Base
  Dotenv.load(File.expand_path('../../config/s3.env', File.dirname(__FILE__)))

  belongs_to :user
  validates :original_text, :translated_text, :review_date, :user, presence: true
  validate :compare
  before_validation :set_date
  has_attached_file(
    :image,
    styles: {medium: "360x360>" },
    storage: :s3,
    s3_access_key_id: ENV['ACCESS_KEY_ID'],
    s3_secret_access_key: ENV['SECRET_ACCESS_KEY'],
    s3_region: ENV['REGION'],
    bucket: 'flashcardsimages',
    s3_protocol: 'https',
    s3_host_name: 's3.eu-central-1.amazonaws.com'
  )
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  scope :review, -> { where(review_date: Date.today) }
   
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
