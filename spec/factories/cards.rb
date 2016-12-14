FactoryGirl.define do
  factory :card do
    original_text 'nicht'
    translated_text 'not'
    review_date Time.now
    wrong_checks 0
    right_checks 0
    association :pack, factory: :pack
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'test_files', 'cat.jpg')) }
    image_content_type "image/jpeg"
  end
end