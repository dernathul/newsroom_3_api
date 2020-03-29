FactoryBot.define do
  factory :user do
    email { "user#{rand(1...9999)}@mail.com" }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'registred_user' }
    factory :journalist do
      role { 'journalist' }
    end
  end
end
