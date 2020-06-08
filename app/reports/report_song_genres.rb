class ReportSongGenres

  attr_reader :heading, :title, :line_length, :separator_line, :report_string_continuation_indent

  def initialize
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @heading = build_heading
    @title = build_title
    @separator_line = ('-' * line_length) + "\n"
  end


  def build_heading
    '%-*s  %-*s  %-s' %
        [Song.max_code_length,      '   Code',
         Song.max_name_length,      'Name',
         '      Genres']
  end


  def build_title
    text = 'Song Genres'
    indentation = ' ' * ((line_length - text.length) / 2)
    indentation + text
  end


  def report_string
    report = StringIO.new
    report << "#{separator_line}#{title}\n#{separator_line}\n\n#{heading}\n\n"
    Song.all.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    '%-*s  %-*s  %s' %
        [Song.max_code_length, record.code, Song.max_name_length, record.name, record.genre_codes.join('  ')]
  end

end