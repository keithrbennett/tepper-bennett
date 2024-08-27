# frozen_string_literal: true

# Shows all YouTube video links whose resources do not exist.

require 'async'
require 'async/http/internet'
require 'yaml'

module VideoChecker
  def self.get_all_videos
    yaml_file = File.join(File.dirname(__FILE__), '../../db/song-plays.yml')
    videos = YAML.load_file(yaml_file)
    videos.each do |video|
      video[:uri] = URI.parse("https://www.youtube.com/watch?v=#{video[:youtube_key]}")
      video[:available] = :uninitialized
    end
  end

  def self.run
    videos = get_all_videos
    puts "Checking #{videos.length} videos..."
    Async do
      internet = Async::HTTP::Internet.new

      videos.each do |video|
        Async do
          response = internet.get(video[:uri])
          available = ! response.read.include?("This video isn't available anymore")
          video[:available] = available
        end
      end
    end
    videos
  end
end

namespace :links do
  desc "Show all YouTube video links that do not exist."
  task :show_unavailable_videos do
    videos = VideoChecker.run
    unavailable_videos = videos.select { |v| ! v[:available] }
    puts JSON.pretty_generate(unavailable_videos)
  end
end