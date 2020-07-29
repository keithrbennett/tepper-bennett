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
    headings = ['Year', 'Code', 'Name', 'Song Code', 'Song Name']
    data = records.each_with_object([])  do |r, data|
      r[:songs].each do |s|
        data << [r[:code], r[:name], s[:code], s[:name]]
      end
    end

    table_data = records_to_html_table_data(data)
    html_report_table(headings, table_data)
  end

  def to_raw_text
    MovieSongsTextReport.new(records).report_string
  end

end
