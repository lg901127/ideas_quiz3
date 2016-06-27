FactoryGirl.define do
  factory :idea, class: 'Ideas' do
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}"}
    body            { Faker::Lorem.paragraph}
  end
end
