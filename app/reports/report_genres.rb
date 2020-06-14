class ReportGenres < BaseReport

  attr_reader :report_title, :line_length, :report_string_continuation_indent

  def initialize
    @line_length = [Genre.max_code_length, Genre.max_name_length].sum + 6
    @report_title = 'Genres'
  end


  def heading
    '%-*s  %-*s  %-s' %
        [Genre.max_code_length,      '   Code',
         Genre.max_name_length,      'Name',
         'Song Count']
  end


  def report_string
    report = StringIO.new
    report << title_banner << "#{heading}\n\n"
    Genre.all.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    '%-*s  %-*s     %3d' %
        [Genre.max_code_length, record.code, Genre.max_name_length, record.name, record.songs.count]
  end

end