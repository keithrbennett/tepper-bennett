require_relative 'base_text_report'

class SongPerformersTextReport < BaseTextReport

  attr_reader :title, :line_length, :report_string_continuation_indent

  def initialize
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @report_title = 'Song Performers'
    @report_string_continuation_indent = ' ' * (Song.max_code_length + Song.max_name_length + 4)
    build_report_hash(data)
  end


  def data
    @data ||= Song.order(:name).map do |song|
      performers = song.performers.map do |performer|
        { 'code' => performer.code, 'name' => performer.name }
      end

      { 'code' => song.code, 'name' => song.name, 'performers' => performers}
    end
  end


  def heading
    '%-*s  %-*s  %-*s  %-*s' %
        [Song.max_code_length,      '   Code',
         Song.max_name_length,      'Name',
         Performer.max_code_length, 'Perf Code',
         Performer.max_name_length, 'Performer Name']
  end


  def report_string
    report = StringIO.new
    report << "#{title_banner}#{heading}\n\n"
    data.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    # performers = record.performers # This results in very strange behavior; see "The Lady Loves Me" in report
    # and Stack Overflow page:
    # https://stackoverflow.com/questions/62273455/activerecord-associationrelation-weird-first-last-behavior

    performers = record['performers']
    sio = StringIO.new
    sio << '%-*s  %-*s  %-*s  %s' %
        [Song.max_code_length, record['code'], Song.max_name_length, record['name'],
         Song.max_code_length, performers&.first&.[]('code'), performers&.first&.[]('name')]

    (performers[1..-1] || []).each do |performer|
      sio << "\n%s%-*s  %s" %
          [@report_string_continuation_indent, Song.max_code_length, performer['code'], performer['name']]
    end
    sio.string
  end

end