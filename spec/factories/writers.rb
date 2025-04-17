FactoryBot.define do
  factory :writer do
    sequence(:code) { |n| "writer-#{n}" }
    sequence(:name) { |n| "Writer Name #{n}" }
  end
end 