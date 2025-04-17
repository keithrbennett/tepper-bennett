FactoryBot.define do
  factory :performer do
    sequence(:code) { |n| "performer-#{n}" }
    sequence(:name) { |n| "Performer Name #{n}" }
  end
end 