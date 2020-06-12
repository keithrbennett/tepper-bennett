class ReportMovies < BaseReport

  attr_reader :report_title, :line_length

  def initialize
    @line_length = calc_line_length
  end


  def calc_line_length
    year_column_length = 4 + 2  # 4 digit year + buffer
    Movie.max_code_length + year_column_length + Movie.max_name_length + 4
  end


  def report_string
    report = StringIO.new

    report_by_order = ->(display_name, order) do
      @report_title = "Movies in #{display_name} Order"
      report << title_banner << "   Code         Year   IMDB Key         Name\n\n"
      Movie.order(order).all.each { |record| report << record_report_string(record) << "\n" }
      report << "\n\n"
      report << 'To build an IMDB URL, append the IMDB key to "https://www.imdb.com/title/".' << "\n"
      report << 'For example, for the key "tt0053848", the URL would be "https://www.imdb.com/title/tt0053848".'
      report << "\n\n\n"
    end

    report_by_order.('Title', :name)
    report_by_order.('Year', :year)
    report.string
  end


  def record_report_string(record)
    '%-14s  %4d   %-*s  %s' % [record.code, record.year, Movie::IMDB_KEY_LENGTH, record.imdb_key, record.name]
  end

end