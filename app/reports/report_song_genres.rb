class ReportSongGenres < BaseReport

  attr_reader :report_title, :line_length, :report_string_continuation_indent

  def initialize
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @report_title = 'Song Genres'
    build_report_hash(data)
  end


  def data
    Song.order(:name).all.map do |song|
      {
          'code'   => song.code,
          'name'   => song.name,
          'genres' => song.genres.pluck(:code).sort
      }
    end
  end


  def heading
    '%-*s  %-*s  %-s' %
        [Song.max_code_length,      '   Code',
         Song.max_name_length,      'Name',
         '      Genres']
  end


  def report_string
    report = StringIO.new
    report << title_banner << "#{heading}\n\n"
    data.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    '%-*s  %-*s  %s' %
        [Song.max_code_length, record['code'], Song.max_name_length, record['name'], record['genres'].join('  ')]
  end

end