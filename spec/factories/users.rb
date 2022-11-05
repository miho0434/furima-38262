FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    date_of_birth         { Faker::Date.birthday(min_age: 18, max_age: 120) }

    japanese_user = Gimei.name
    family_name           { japanese_user.last.kanji }
    first_name            { japanese_user.first.kanji }
    family_name_kana      { japanese_user.last.katakana }
    first_name_kana       { japanese_user.first.katakana }
  end
end
