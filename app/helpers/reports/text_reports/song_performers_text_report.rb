require_relative 'base_text_report'

class SongPerformersTextReport < BaseTextReport

  attr_reader :records, :title, :line_length

  def initialize(records)
    @records = records
    @line_length = [Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 6
    @title = 'Song Performers'
    build_report_hash(records)
  end


  def formatted_data_line(song_code, song_name, perf_code, perf_name)
    '%-*s  %-*s  %-*s  %-*s' %
        [Song.max_code_length,      song_code,
         Song.max_name_length,      song_name,
         Performer.max_code_length, perf_code,
         Performer.max_name_length, perf_name]
  end


  def heading
    formatted_data_line('   Code', 'Name', 'Perf Code', 'Performer Name')
  end


  def report_string
    report = StringIO.new
    report << "#{title_banner}#{heading}\n\n"
    records.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    # performers = record.performers # This results in very strange behavior; see "The Lady Loves Me" in report
    # and Stack Overflow page:
    # https://stackoverflow.com/questions/62273455/activerecord-associationrelation-weird-first-last-behavior

    performers = record[:performers]
    sio = StringIO.new
    sio << formatted_data_line(record[:code], record[:name], performers[0][:code], performers[0][:name])

    (performers[1..-1] || []).each do |performer|
      sio << "\n" + formatted_data_line('', '', performer[:code], performer[:name])
    end
    sio.string
  end

end