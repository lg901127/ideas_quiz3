FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph}
    product nil
  end
end
