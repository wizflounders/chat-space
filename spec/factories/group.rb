FactoryGirl.define do
  factory :group do
    name  {Faker::Name.name}
    updated_at { Faker::Time.between(2.days.ago, 1.days.ago, :all) }
  end
end
