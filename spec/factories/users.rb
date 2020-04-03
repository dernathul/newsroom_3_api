FactoryBot.define do
  factory :user do
    email { "user#{rand(1...9999)}@mail.com" }
    password { "password" }
    password_confirmation { "password" }
    role { "reg_user" }
    factory :subscriber do
      role { "subscriber" }
    end
    factory :journalist do
      role { "journalist" }
    end
    factory :editor do
      role { "editor" }
    end
  end
end
