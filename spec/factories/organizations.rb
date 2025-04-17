FactoryBot.define do
  factory :organization do
    sequence(:code) { |n| "org-#{n}" }
    sequence(:name) { |n| "Organization #{n}" }
  end
end 