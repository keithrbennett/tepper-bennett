class ReportSongPlays < BaseReport

  attr_reader :report_title, :line_length, :report_string_continuation_indent

  YOUTUBE_KEY_LENGTH = SongPlay::YOUTUBE_KEY_LENGTH

  def initialize
    @line_length = [YOUTUBE_KEY_LENGTH, Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 8
    @report_title = 'Song Plays (YouTube)'
    @report_string_continuation_indent = Song.max_code_length + Song.max_name_length + 4
    build_report_hash(data)
  end


  def data
    return @data if @data

    records = SongPlay.joins(:song).all.order('songs.name, id').map do |song_play|
      performers = song_play.performers.order(:name).map do |performer|
        { 'code' => performer.code, 'name' => performer.name }
      end
      {
        'song_code'   => song_play.song.code,
        'song_name'   => song_play.song.name,
        'youtube_key' => song_play.youtube_key,
        'performers'  => performers
      }
    end

    @data = records.sort_by do |record|
      [record['song_name'], record['performers'].map { |p| p['name']}]
    end
  end


  def heading
    '%-*s  %-*s  %-*s  %-*s  %-*s' %
        [
            YOUTUBE_KEY_LENGTH,        'YouTube Key',
            Song.max_code_length,      'Song Code',
            Performer.max_code_length, 'Perf Code',
            Song.max_name_length,      'Song Name',
            Performer.max_name_length, 'Performer Name'
        ]
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

    sio = StringIO.new
    sio << '%-*s  %-*s  %-*s  %-*s  %-*s' %
        [
            YOUTUBE_KEY_LENGTH,          record['youtube_key'],
            Song.max_code_length,        record['song_code'],
            Performer.max_code_length,   record['performers'][0]['code'],
            Song.max_name_length,        record['song_name'],
            Performer.max_name_length,   record['performers'][0]['name']
        ]

    # performers[1..-1].each do |performer|
    #   sio << "\n%-*s%-*s  %s" %
    #       [@report_string_continuation_indent, '', Song.max_code_length, performer.code, performer.name]
    # end
    sio.string
  end

end