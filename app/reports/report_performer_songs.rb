class ReportPerformerSongs < BaseReport

  attr_reader :report_title, :line_length, :report_string_continuation_indent

  def initialize
    @line_length = [Performer.max_code_length, Performer.max_name_length, Song.max_code_length, Song.max_name_length].sum + 6
    @report_title = 'Performer Songs'
    @report_string_continuation_indent = ' ' * (Performer.max_code_length + Performer.max_name_length + 4)
    build_report_hash(data)
  end


  def data
    @data ||= Performer.order(:name).map do |performer|
      songs = performer.songs.order(:name).map { |song| attr_hash(song, %w{code name})}
      attr_hash(performer, %w{code name}).merge({ 'songs' => songs})
    end
  end


  def heading
    '%-*s  %-*s  %-*s  %-*s' %
        [Performer.max_code_length,      'Perf Code',
         Performer.max_name_length,      'Performer Name',
         Song.max_code_length, 'Song Code',
         Song.max_name_length, 'Song Name']
  end


  def report_string
    report = StringIO.new
    report << "#{title_banner}#{heading}\n\n"
    data.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report << performers_no_songs << "\n\n"
    report.string
  end


  def record_report_string(record)
    songs = record['songs']
    sio = StringIO.new
    sio << '%-*s  %-*s  %-*s  %s' %
        [Performer.max_code_length, record['code'], Performer.max_name_length, record['name'],
         Song.max_code_length, songs&.first&.[]('code'), songs&.first&.[]('name')]

    (songs[1..-1] || []).each do |song|
      sio << "\n%s%-*s  %s" %
          [@report_string_continuation_indent, Song.max_code_length, song['code'], song['name']]
    end
    sio.string
  end

  def performers_no_songs
    orphans = Performer.all.order(:name).to_a.select { |p| p.songs.nil? || p.songs.empty? }.pluck(:name)
    return '' if orphans.empty?
    sio = StringIO.new
    sio << "The following performers do not have any songs associated with them:\n\n"
    sio << orphans.join("\n")
    sio << "\n\n"
    sio.string
  end
end