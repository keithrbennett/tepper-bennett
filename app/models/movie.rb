class Movie < ApplicationRecord

  has_and_belongs_to_many :songs

  validates :name, presence: true
  validates :name, uniqueness: true

end
