require_relative 'base_text_report'

module Reports; module TextReports
  class SongPlaysTextReport < BaseTextReport

    attr_reader :records, :title, :line_length

    YOUTUBE_KEY_LENGTH = SongPlay::YOUTUBE_KEY_LENGTH

    def initialize(records)
      @records = records
      @line_length = [YOUTUBE_KEY_LENGTH, Song.max_code_length, Song.max_name_length, Performer.max_code_length, Performer.max_name_length].sum + 8
      @title = 'Song Plays (YouTube)'
      build_report_hash(records)
    end


    def formatted_data_line(youtube_key, song_code, perf_code, song_name, perf_name)
      '%-*s  %-*s  %-*s  %-*s  %-*s' %
          [
              YOUTUBE_KEY_LENGTH,        youtube_key,
              Song.max_code_length,      song_code,
              Performer.max_code_length, perf_code,
              Song.max_name_length,      song_name,
              Performer.max_name_length, perf_name
          ]
    end


    def heading
      formatted_data_line('YouTube Key', 'Song Code', 'Perf Code', 'Song Name', 'Performer Name')
    end


    def report_string
      report = StringIO.new
      report << "#{title_banner}#{heading}\n\n"
      records.each { |record| report << record_report_string(record) << "\n" }
      report << "\n\n"
      report.string
    end


    def record_report_string(record)
      performers = record[:performers]
      sio = StringIO.new
      sio << formatted_data_line(record[:youtube_key], record[:song_code], performers[0][:code], record[:song_name], performers[0][:name])

      performers[1..-1].each do |performer|
        sio << "\n" << formatted_data_line('', '', performer[:code], '', performer[:name])
      end
      sio.string
    end

  end
end end
