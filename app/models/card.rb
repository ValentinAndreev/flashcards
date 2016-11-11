class Card < ActiveRecord::Base
    validates :original_text, :translated_text, :review_date, presence: true  
    before_save :set_date
    
protected
    def set_date
      if review_date.nil?
        self.review_date = Time.now.to_date+3
      end
    end    
end
