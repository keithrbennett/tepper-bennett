FactoryBot.define do
  factory :song_play do
    sequence(:code) { |n| "song-play-#{n}" }
    youtube_key { "abc#{rand(10000)}" }
    association :song
  end
end 