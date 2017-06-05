include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :message do
    body { Faker::Lorem.sentence }
    image { fixture_file_upload Rails.root.join('spec', 'fixtures','img', 'test.jpg')}
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
  end

  factory :invalid_msg do
    body nil
    image nil
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
  end
end
