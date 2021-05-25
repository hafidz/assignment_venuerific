FactoryBot.define do
  factory :user do
    email { (0...50).map { ('a'..'z').to_a[rand(26)] }.join + "@mailinator.com" }
    password { '123456' }
    fullname { 'User' }
  end
end