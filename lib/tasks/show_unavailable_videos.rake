# frozen_string_literal: true

# Shows all YouTube video links that do not exist.

require 'json'

GET_ALL_SONG_PLAYS = -> do
  yaml_file = File.join(File.dirname(__FILE__), '../../db/song-plays.yml')
  YAML.load_file(yaml_file)

  # https://www.youtube.com/watch?v=E2J13o-RsxA
  # [
  #   { title: 'am-i-ready', performer: 'elvis', youtube_key: 'E2J13o-RsxA'}
  # ]
end

VIDEO_UNAVAILABLE = ->(video) do
  uri = URI.parse("https://www.youtube.com/watch?v=#{video[:youtube_key]}")
  print("Checking #{uri}...")
  response = Net::HTTP.get_response(uri)
  unavailable = response.body.include?("This video isn't available anymore")
  puts(unavailable ? ' unavailable' : ' available')
  unavailable
end

UNAVAILABLE_VIDEOS = -> do
  videos = GET_ALL_SONG_PLAYS.call
  unavail_videos = videos.select { |video| VIDEO_UNAVAILABLE.call(video) }
  puts "Found #{unavail_videos.size} unavailable video(s):\n"
  unavail_videos
end

namespace :links do
  desc "Show all YouTube video links that do not exist."
  task :show_unavailable_videos do
    unavail_videos = UNAVAILABLE_VIDEOS.call
    puts JSON.pretty_generate(unavail_videos)
  end
end
