FactoryGirl.define do
  pass = Faker::Internet.password(8)

  factory :user do
    name                  Faker::Name.name
    email                 Faker::Internet.email
    password              pass
    password_confirmation pass

    after(:create) do |user|
      temp_group = create(:group)
      create(:group_user, user: user, group: temp_group)
    end
  end
end
