class ReportSongGenres < BaseReport

  attr_reader :heading, :report_title, :line_length, :separator_line, :report_string_continuation_indent

  def initialize
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @heading = build_heading
    @report_title = title_with_gen_date('Song Genres')
  end


  def build_heading
    '%-*s  %-*s  %-s' %
        [Song.max_code_length,      '   Code',
         Song.max_name_length,      'Name',
         '      Genres']
  end


  def report_string
    report = StringIO.new
    report << "#{separator_line}#{title_indentation}#{report_title}\n#{separator_line}\n\n#{heading}\n\n"
    Song.all.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    '%-*s  %-*s  %s' %
        [Song.max_code_length, record.code, Song.max_name_length, record.name, record.genre_codes.join('  ')]
  end

end