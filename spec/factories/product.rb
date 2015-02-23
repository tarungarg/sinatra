FactoryGirl.define do
  factory :product do
    name Faker::Name.name
    price Faker::Commerce.price
    status ["on", "off"]
    description Faker::Lorem.sentence
  end
end