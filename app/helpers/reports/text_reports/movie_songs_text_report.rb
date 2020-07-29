require_relative 'base_text_report'

class MovieSongsTextReport < BaseTextReport

  attr_reader :records, :title, :line_length

  def initialize(records)
    @records = records
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @title = 'Songs by Movie'
    build_report_hash(records)
  end


  def formatted_data_line(year, movie_code, movie_name, song_code, song_name)
    '%-4.4s  %-*s  %-*s  %-*s  %-*s' % [
        year.to_s,
        Movie.max_code_length, movie_code,
        Movie.max_name_length, movie_name,
        Song.max_code_length,  song_code,
        Song.max_name_length, song_name
    ]
  end

  def heading
    formatted_data_line('Year',  '   Code', 'Name', 'Song Code', 'Song Name')
  end


  def report_string
    report = StringIO.new
    report << "#{title_banner}#{heading}\n"
    records.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    songs = record[:songs]
    sio = StringIO.new
    sio << "\n"

    ap record

    sio << formatted_data_line(record[:year], record[:code], record[:name], songs.first&.[](:code), songs.first&.[](:name))

    (songs[1..-1] || []).each do |song|
      sio << "\n" << formatted_data_line('', '', '', song[:code], song[:name])
    end
    sio.string
  end

end