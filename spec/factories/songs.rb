FactoryBot.define do
  factory :song do
    sequence(:code) { |n| "song-#{n}" }
    sequence(:name) { |n| "Song Name #{n}" }
  end
end 