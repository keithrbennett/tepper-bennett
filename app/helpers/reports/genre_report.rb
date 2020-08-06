class GenreReport < BaseReport

  attr_reader :records, :tuples

  def initialize
    @report_type = 'genres'
  end

  def populate
    @tuples = Genre.order(:name).map do |genre|
      [genre.code, genre.name, genre.songs.count]
    end
    @records = tuples.map do |tuple|
      { code: tuple[0], name: tuple[1], song_count: tuple[2] }
    end
  end

  def to_html
    render partial: 'reports/report_table', locals:
        { table_id: "genre-report-table", column_headings: ['Genre Code', 'Genre Name', 'Song Count'], records: tuples }
  end

  def to_raw_text
    GenreTextReport.new(records).report_string
  end
end