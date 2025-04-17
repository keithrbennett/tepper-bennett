class Song < ApplicationRecord

  has_and_belongs_to_many :movies
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :performers
  has_and_belongs_to_many :writers
  has_and_belongs_to_many :rights_admin_orgs, class_name: 'Organization'
  has_many :song_plays

  def self.max_name_length = 50

  validates_length_of :code, maximum: max_code_length
  validates_length_of :name, maximum: max_name_length

  validates :name, presence: true
  validates :name, uniqueness: true

  # Add a genre to a song. Adding one that already exists has no effect. Raises error if code not valid.
  def add_genre(genre_code)
    return if genre_codes.include?(genre_code)
    genre = Genre.find_by_code(genre_code)
    if genre
      genres << genre
    else
      raise "Genre for code #{genre_code} not found" if genre.nil?
    end
  end


  def performer_codes = performers.pluck(:code).sort

  def genre_codes = genres.pluck(:code).sort
end
