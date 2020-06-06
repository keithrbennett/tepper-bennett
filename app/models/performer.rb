class Performer < ApplicationRecord

  has_and_belongs_to_many :songs
  has_and_belongs_to_many :song_plays

  validates :name, presence: true
  validates :name, uniqueness: true

end
