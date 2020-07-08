class GenreReport < BaseReport

  attr_reader :records, :tuples

  def initialize
    @tuples = Genre.order(:name).map do |genre|
      [genre.code, genre.name, genre.songs.count]
    end
    @records = tuples.map do |tuple|
      { code: tuple[0], name: tuple[1], song_count: tuple[2] }
    end
  end

  def to_html
    table_data = records_to_html_table_data(tuples)
    html_report_table(['Genre Code', 'Genre Name', 'Song Count'], table_data)
  end

  def to_raw_text
    GenreTextReport.new(records).report_string
  end

end