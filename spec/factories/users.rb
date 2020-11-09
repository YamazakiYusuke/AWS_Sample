FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString@gmail.com" }
    password_digest { "MyString" }
  end
end
