FactoryGirl.define do
  factory :user do
  	firstname Faker::Name.first_name
  	lastname Faker::Name.last_name
  	email Faker::Internet.email
  	password Faker::Internet.password(8, 20)
  	factory :user_with_products do
      after(:create) do |user, evaluator|
        create_list(:product, 5)
      end
    end
  end
end