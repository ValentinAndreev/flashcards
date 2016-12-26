FactoryGirl.define do
  factory :card do
    original_text 'abstraktheit'
    translated_text 'abstractiveness'
    review_date Time.now
    checks 0
    review_time 0
    ef 2.5
    q 0
    association :pack, factory: :pack
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'test_files', 'cat.jpg')) }
    image_content_type "image/jpeg"
  end
end