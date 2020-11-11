FactoryBot.define do
  factory :user do
    name { "Yokoi" }
    email { "yokoi@gmail.com" }
    password { "hogehoge" }
    password_confirmation { "hogehoge" }
    admin { 'false' }
  end
end
