# frozen_string_literal: true

# Shows all YouTube video links that do not exist.

require 'json'
require 'net/http'
require 'yaml'

module VideoChecker
  def self.get_all_videos
    yaml_file = File.join(File.dirname(__FILE__), '../../db/song-plays.yml')
    YAML.load_file(yaml_file)

    # For experimentation:
    # https://www.youtube.com/watch?v=E2J13o-RsxA
    # [
    #   { title: 'am-i-ready', performer: 'elvis', youtube_key: 'E2J13o-RsxA'}
    # ]
  end

  def self.video_unavailable?(video)
    uri = URI.parse("https://www.youtube.com/watch?v=#{video[:youtube_key]}")
    print("Checking #{uri}...")
    response = Net::HTTP.get_response(uri)
    unavailable = response.body.include?("This video isn't available anymore")
    puts(unavailable ? ' unavailable' : ' available')
    unavailable
  end

  def self.unavailable_videos
    videos = get_all_videos
    unavail_videos = videos.select { |video| video_unavailable?(video) }
    puts "Found #{unavail_videos.size} unavailable video(s):\n"
    unavail_videos
  end
end

namespace :links do
  desc "Show all YouTube video links that do not exist."
  task :show_unavailable_videos do
    puts JSON.pretty_generate(VideoChecker.unavailable_videos)
  end
end