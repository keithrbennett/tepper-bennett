class Song < ApplicationRecord

  has_and_belongs_to_many :movies
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :performers
  has_and_belongs_to_many :writers
  has_and_belongs_to_many :rights_admin_orgs, class_name: 'Organization'
  has_many :song_plays

  validates :name, presence: true
  validates :name, uniqueness: true

end
