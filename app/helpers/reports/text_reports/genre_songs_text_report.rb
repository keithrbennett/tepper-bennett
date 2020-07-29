require_relative 'base_text_report'

class GenreSongsTextReport < HasManyTextReport

  attr_reader :records, :title

  def initialize(records)
    super(records, 'Songs by Genre', Genre, Song)
  end
end