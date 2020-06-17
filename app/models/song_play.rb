class SongPlay < ApplicationRecord

  belongs_to :song
  has_and_belongs_to_many :performers

  validates_length_of :code, maximum: max_code_length

  YOUTUBE_KEY_LENGTH = 11
  YOUTUBE_WATCH_URL_LENGTH = 43
  YOUTUBE_EMBED_URL_LENGTH = 41

  def self.youtube_watch_url(youtube_key)
    "https://www.youtube.com/watch?v=#{youtube_key}"
  end

  def youtube_watch_url
    self.class.youtube_watch_url(youtube_key)
  end

  def self.youtube_embed_url(youtube_key)
    "https://www.youtube.com/embed/#{youtube_key}"
  end

  def youtube_embed_url
    self.class.youtube_embed_url(youtube_key)
  end
end
