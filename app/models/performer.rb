class Performer < ApplicationRecord

  has_and_belongs_to_many :songs
  has_and_belongs_to_many :song_plays


  def self.max_name_length
    60
  end


  validates_length_of :code, maximum: max_code_length
  validates_length_of :name, maximum: max_name_length

  validates :name, presence: true
  validates :name, uniqueness: true

end
