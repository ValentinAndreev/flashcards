FactoryGirl.define do
  factory :pack do
    title "MyPack"
    association :user, factory: :user
  end
end
