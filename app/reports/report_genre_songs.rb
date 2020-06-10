class ReportGenreSongs < BaseReport

  attr_reader :report_title, :ar_class


  def initialize
    @report_title = 'Songs by Genre'
  end


  def line_length
    Song.max_code_length + Song.max_name_length + 2
  end


  def report_string
    report = StringIO.new

    report << title_banner
    Genre.order(:name).all.each_with_index do |record, index|
      if index > 0
        report << separator_line << "\n"
      end
      report << "Genre: #{record.name}\n\n"
      report << record_report_string(record) << "\n"
    end
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    songs = record.songs
    sio = StringIO.new
    if songs.empty?
      sio << "[None]\n"
    else
      songs.each do |song|
        sio << ("%-*s  %-s\n" %
            [Song.max_code_length, song.code, song.name])
      end
    end

    sio.string
  end

end