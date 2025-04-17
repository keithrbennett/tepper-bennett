FactoryBot.define do
  factory :genre do
    sequence(:code) { |n| "genre-#{n}" }
    sequence(:name) { |n| "Genre #{n}" }
  end
end 