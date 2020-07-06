require_relative 'base_text_report'

class MovieTextReport < BaseTextReport

  attr_reader :records, :title, :line_length

  def initialize(records)
    @records = records
    @title = "Movies"
    @line_length = calc_line_length
    build_report_hash(records)
  end


  def calc_line_length
    year_column_length = 4 + 2  # 4 digit year + buffer
    Movie.max_code_length + year_column_length + Movie.max_name_length + 4
  end


  def report_string
    report = StringIO.new
    report << title_banner << "   Code         Year   IMDB Key         Name\n\n"
    records.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report << 'To build an IMDB URL, append the IMDB key to "https://www.imdb.com/title/".' << "\n"
    report << 'For example, for the key "tt0053848", the URL would be "https://www.imdb.com/title/tt0053848".'
    report << "\n\n\n"
    report.string
  end


  def record_report_string(record)
    '%-14s  %4d   %-*s   %s' % [record[:code], record[:year], Movie::IMDB_KEY_LENGTH, record[:imdb_key], record[:name]]
  end

end