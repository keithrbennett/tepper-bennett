class MovieSongsReport < BaseReport

  attr_reader :records

  def initialize
    @records = Movie.order(:name).map do |movie|
      songs = pluck_to_hash(movie.songs.order(:name), :code, :name)
      { year: movie.year, code: movie.code, name: movie.name, songs: songs }
    end
  end

  def to_html
    headings = ['Year', 'Code', 'Name', 'Song Code', 'Song Name']
    html_data = records.map do |r|
      [
          r[:year],
          r[:code],
          r[:name],
          r[:songs].pluck(:code).join('<br/>') ,
          r[:songs].pluck(:name).join('<br/>') ,
      ]
    end

    table_data = records_to_html_table_data(html_data)
    html_report_table(headings, table_data)
  end

  def to_raw_text
    MovieSongsTextReport.new(records).report_string
  end

end
