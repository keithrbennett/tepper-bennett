# lib/tasks/inaccessible_links.rake
require 'net/http'
require 'uri'

LOAD_YOUTUBE_KEYS = -> do
  song_plays = YAML.load_file(File.join(File.dirname(__FILE__), '../../db/song-plays.yml'))
  youtube_keys = song_plays.pluck(:youtube_key)
end

URL_UNEMBEDDABLE = ->(url) do
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  unembeddable = [
    'player-unavailable',
    'Video unavailable',
  ].all? { |str| response.body.include?(str) }
  unembeddable
end

namespace :links do
  desc "Check for unembeddable links"
  task :check_unembeddable do

    youtube_keys = LOAD_YOUTUBE_KEYS.call
    embeds = youtube_keys.map { |key| "https://www.youtube.com/embed/#{key}" }

    unembeddable_urls, embeddable_urls = embeds.partition { |url| URL_UNEMBEDDABLE.call(url) }

    puts("\n\n#{unembeddable_urls.size} unembeddable links:\n#{unembeddable_urls.join("\n")}")
    puts("\n\n#{embeddable_urls.size} embeddable links:\n#{embeddable_urls.join("\n")}")
  end
end

