FactoryBot.define do
  factory :movie do
    sequence(:code) { |n| "movie-#{n}" }
    sequence(:name) { |n| "Movie Title #{n}" }
    year { 1960 + rand(20) }
  end
end 