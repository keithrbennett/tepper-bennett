class GenreSongsReport < HasManyReport

  def initialize
    super(
        records: build_records,
        title: 'Genre Songs',
        primary_ar_class: Genre,
        secondary_ar_class: Song,
        text_report_class_name: GenreSongsTextReport
    )
    @report_type = 'genre_songs'
  end

  def build_records
    Genre.order(:name).all.map do |genre|
      {
          name: genre.name,
          songs: pluck_to_hash(genre.songs.order(:name), :code, :name)
      }
    end
  end
end
