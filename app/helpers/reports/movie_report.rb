class MovieReport < BaseReport

  attr_reader :records, :tuples

  def initialize
    @report_type = 'movies'
  end

  def populate
    @records = pluck_to_hash(Movie.order(:name), :code, :year, :name, :imdb_key)
  end

  def to_html
    headings = ['Code', 'Year', 'IMDB Key', 'Name']
    table_data = records.map do |movie|
      [
          movie[:code],
          movie[:year],
          render_to_string(partial: 'reports/movie_imdb_field', locals: { imdb_key: movie[:imdb_key] }),
          movie[:name],
      ]
    end
    locals = { table_id: 'movie-report-table', column_headings: headings, records: table_data }
    render partial: 'reports/report_table', locals: locals
  end

  def to_raw_text
    MovieTextReport.new(records).report_string
  end

end
