class ReportSongs

  attr_reader :heading, :title, :line_length, :separator_line, :report_string_continuation_indent

  def initialize
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @heading = build_heading
    @title = build_title
    @report_string_continuation_indent = Song.max_code_length + Song.max_name_length + 4
    @separator_line = ('-' * line_length) + "\n"
  end


  def build_heading
    '%-*s  %-*s  %-*s  %-*s' %
        [Song.max_code_length,      '   Code',
         Song.max_name_length,      'Name',
         Performer.max_code_length, 'Perf Code',
         Performer.max_name_length, 'Performer Name']
  end


  def build_title
    text = 'Songs'
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
    performers = record.performers.all.to_a
    sio = StringIO.new
    sio << '%-*s  %-*s  %-*s  %s' %
        [Song.max_code_length, record.code, Song.max_name_length, record.name,
         Song.max_code_length, performers[0].code, performers[0].name]
    performers[1..-1].each do |performer|
      sio << ("\n%-*s%-*s  %s" %
          [@report_string_continuation_indent, '', Song.max_code_length, performer.code, performer.name])
    end
    sio.string
  end

end