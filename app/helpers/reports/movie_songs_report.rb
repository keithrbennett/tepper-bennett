class MovieSongsReport < BaseReport

  attr_reader :records

  def initialize
    @report_type = 'movie_songs'
  end

  def populate
    @records = Movie.order(:name).map do |movie|
      songs = pluck_to_hash(movie.songs.order(:name), :code, :name)
      { year: movie.year, code: movie.code, name: movie.name, songs: songs }
    end
  end

  def to_html
    render partial: 'reports/movie_songs', locals: { records: records }
  end

  def to_raw_text
    MovieSongsTextReport.new(records).report_string
  end

end
