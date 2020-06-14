class ReportGenreSongs < BaseReport

  attr_reader :report_title, :ar_class


  def initialize
    @report_title = 'Songs by Genre'
    build_report_hash(data)
  end


  def data
    @data ||= Genre.order(:name).all.each_with_object({}) do |genre, songs_by_genre|
      songs = genre.songs
      songs_by_genre[genre.name] = songs.map { |song| { 'code' => song.code, 'name' => song.name } }
    end
  end


  def line_length
    Song.max_code_length + Song.max_name_length + 2
  end


  def report_string
    report = StringIO.new

    report << title_banner
    data.each do |genre, songs|
      (report << separator_line << "\n") if genre != data.keys.first   # omit '----' on first genre
      report << "Genre: #{genre}\n\n"
      report << record_report_string(songs) << "\n"
    end
    report << "\n\n"
    report.string
  end


  def record_report_string(songs)
    sio = StringIO.new
    if songs.empty?
      sio << "[None]\n"
    else
      songs.each do |song|
        sio << ("%-*s  %-s\n" %
            [Song.max_code_length, song['code'], song['name']])
      end
    end

    sio.string
  end

end