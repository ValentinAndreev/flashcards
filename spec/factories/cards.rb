FactoryGirl.define do
  factory :card do
    original_text 'nicht'
    translated_text 'not'
    review_date Date.today
    association :user, factory: :user
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'test_files', 'cat.jpg')) }
    image_content_type "image/jpeg"
  end
end