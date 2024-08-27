# frozen_string_literal: true

# Shows all YouTube video links that do not exist.

require 'json'
require 'net/http'
require 'yaml'

module VideoChecker
  def self.get_all_videos
    yaml_file = File.join(File.dirname(__FILE__), '../../db/song-plays.yml')
    YAML.load_file(yaml_file)
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
    unavailable_videos = []
    max_threads = 20

    videos.each_slice(max_threads) do |video_batch|
      thread_pool = video_batch.map do |video|
        # The code below is not threadsafe!
        Thread.new { unavailable_videos << video if video_unavailable?(video) }
      end
      thread_pool.each(&:join)
    end

    puts "Found #{unavailable_videos.size} unavailable video(s):\n"
    unavailable_videos
  end
end

namespace :links do
  desc "Show all YouTube video links that do not exist."
  task :show_unavailable_videos do
    puts JSON.pretty_generate(VideoChecker.unavailable_videos)
  end
end