class ReportMovieSongs < BaseReport

  attr_reader :report_title, :line_length, :report_string_continuation_indent

  def initialize
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @report_title = 'Songs by Movie'
    @report_string_continuation_indent = Movie.max_code_length + Movie.max_name_length + 4 + 6 # 6 = 4-digit year + 2
  end


  def heading
    'Year  %-*s  %-*s  %-*s  %-*s' %
        [Movie.max_code_length,      '   Code',
         Movie.max_name_length,      'Name',
         Song.max_code_length, 'Song Code',
         Song.max_name_length, 'Song Name']
  end


  def report_string
    report = StringIO.new
    report << "#{title_banner}#{heading}\n\n"
    Movie.order(:year, :name).all.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    songs = record.songs.order(:name).all.to_a
    sio = StringIO.new
    sio << "\n"
    sio << '%4d  %-*s  %-*s  %-*s  %s' %
        [record.year, Movie.max_code_length, record.code, Movie.max_name_length, record.name,
         Song.max_code_length, songs.first.code, songs.first.name]
    songs[1..-1].each do |song|
      sio << ("\n%-*s%-*s  %s" %
          [@report_string_continuation_indent, '', Song.max_code_length, song.code, song.name])
    end
    sio.string
  end

end