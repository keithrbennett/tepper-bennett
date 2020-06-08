class ReportGenreSongs


  def line_length
    Song.max_code_length + Song.max_name_length + 2
  end


  def title_indent(title)
    (line_length - title.length) / 2
  end


  def separator_line
    ('-' * line_length) + "\n"
  end


  def report_string
    report = StringIO.new

    report << separator_line
    report_title = 'Songs by Genre'
    indentation = ' ' * title_indent(report_title)
    report << "%s%-s\n%s\n\n\n" % [indentation, report_title, separator_line]
    Genre.order(:name).all.each_with_index do |record, index|
      report << separator_line if index > 0
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