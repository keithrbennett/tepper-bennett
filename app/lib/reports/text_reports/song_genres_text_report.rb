require_relative 'base_text_report'

class SongGenresTextReport < BaseTextReport

  attr_reader :records, :title, :line_length

  def initialize(records)
    @records = records
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @title = 'Song Genres'
    build_report_hash(records)
  end


  def formatted_data_line(song_code, song_name, genres)
    '%-*s  %-*s  %-s' %
        [Song.max_code_length, song_code, Song.max_name_length, song_name, genres]
  end

  def heading
    formatted_data_line('   Code', 'Name', '      Genres')
  end


  def report_string
    report = StringIO.new
    report << title_banner << "#{heading}\n\n"
    records.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    formatted_data_line(record[:code], record[:name], record[:genres].join('  '))
  end

end