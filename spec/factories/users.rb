FactoryBot.define do
  factory :user do
    name                    {Faker::Name.initials(number: 2)}
    email                   {Faker::Internet.email}
    password                { Faker::Lorem.characters(number: 4) + Faker::Number.number(digits: 2).to_s }
    password_confirmation   {password}
    birthday                { Faker::Date.birthday(min_age: 18, max_age: 65) }
    vocal_range_id          { VocalRange.pluck(:id).sample }
    direct_messages_enabled { [true, false].sample }
    profile                 { Faker::Lorem.paragraph }
    image                   { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg') }
  end
end