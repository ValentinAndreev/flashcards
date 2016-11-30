FactoryGirl.define do
  factory :card do
    original_text 'nicht'
    translated_text 'not'
    review_date Date.today
    association :user, factory: :user     
    image_file_name '/home/z/Rails/flashcards/spec/files/cat.jpg'
    image_content_type "image/jpeg"
    image_file_size 62122
    image_updated_at "2016-11-30 07:10:31"    
  end
end