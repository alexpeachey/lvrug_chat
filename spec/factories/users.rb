# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:uid) {|n| "uid#{n}"}
    sequence(:name) {|n| "user#{n}"}
  end
end
