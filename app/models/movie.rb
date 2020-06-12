class Movie < ApplicationRecord

  has_and_belongs_to_many :songs

  validates_length_of :code, maximum: max_code_length
  validates :name, presence: true
  validates :name, uniqueness: true

  def imdb_url
    "https://www.imdb.com/title/#{imdb_key}/"
  end
end
