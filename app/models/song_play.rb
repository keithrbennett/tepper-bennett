class SongPlay < ApplicationRecord

  belongs_to :song
  has_and_belongs_to_many :performers

end
