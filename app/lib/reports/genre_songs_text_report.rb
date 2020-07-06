require_relative 'base_text_report'

class GenreSongsTextReport < BaseTextReport

  attr_reader :records, :title


  def initialize(records)
    @records = records
    @title = 'Songs by Genre'
    build_report_hash(records)
  end


  def line_length
    Song.max_code_length + Song.max_name_length + 2
  end


  def report_string
    report = StringIO.new

    report << title_banner
    records.each_with_index do |genre, index|
      (report << separator_line << "\n") unless index == 0 # omit '----' on first genre
      report << "Genre: #{genre[:name]}\n\n"
      report << record_report_string(genre[:songs]) << "\n"
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
            [Song.max_code_length, song[:code], song[:name]])
      end
    end

    sio.string
  end

end