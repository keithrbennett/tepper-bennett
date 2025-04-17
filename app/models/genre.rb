class Genre < ApplicationRecord

  has_and_belongs_to_many :songs

  def self.max_name_length = 12

  validates_length_of :code, maximum: max_code_length
  validates_length_of :name, maximum: max_name_length
  validates :name, presence: true
  validates :name, uniqueness: true

end
