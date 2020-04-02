FactoryBot.define do
  factory :article do
    title { "SPACE" }
    snippet { "Is space the next place?" }
    content { "Lau has become the president of space." }
    category { "tech" }
    trait :with_image do
      image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png') }
    end
  end
end
