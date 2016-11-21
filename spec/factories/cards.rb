FactoryGirl.define do
  factory :card do
    original_text 'nicht'
    translated_text 'not'
    review_date Date.today
  end
end