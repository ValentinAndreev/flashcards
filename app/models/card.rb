class Card < ActiveRecord::Base
    validates :original_text, :translated_text, :review_date, presence: true
    validate :compare
    before_validation :set_date
    
protected
    def set_date
        self.review_date ||= Time.now.to_date+3
    end    
    
   def compare
        errors.add(:original_text, "Equal text") if self.original_text.downcase! == self.translated_text.downcase!
   end
end
