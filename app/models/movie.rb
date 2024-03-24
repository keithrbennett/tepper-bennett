module Models
  class Movie < ApplicationRecord

    has_and_belongs_to_many :songs

    validates_length_of :code, maximum: max_code_length
    validates :name, presence: true
    validates :name, uniqueness: true

    IMDB_KEY_LENGTH = 9
    IMDB_URL_LENGTH = 27 + IMDB_KEY_LENGTH

    def self.imdb_url(imdb_key)
      "https://www.imdb.com/title/#{imdb_key}/"
    end

    def imdb_url
      self.class.imdb_url(imdb_key)
    end
  end
end
