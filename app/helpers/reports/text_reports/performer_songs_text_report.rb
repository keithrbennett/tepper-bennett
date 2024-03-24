require_relative 'base_text_report'

module Reports; module TextReports
  class PerformerSongsTextReport < BaseTextReport

    attr_reader :records, :title, :line_length

    def initialize(records)
      @records = records
      @line_length = [Performer.max_code_length, Performer.max_name_length, Song.max_code_length, Song.max_name_length].sum + 6
      @title = 'Performer Songs'
      build_report_hash(records)
    end


    def formatted_data_line(perf_code, perf_name, song_code, song_name)
      '%-*s  %-*s  %-*s  %-*s' %
          [Performer.max_code_length,  perf_code,
           Performer.max_name_length,  perf_name,
           Song.max_code_length,       song_code,
           Song.max_name_length,       song_name]
    end

    def heading
      formatted_data_line('Perf Code', 'Performer Name', 'Song Code', 'Song Name')
    end


    def report_string
      report = StringIO.new
      report << "#{title_banner}#{heading}\n\n"
      records.each { |record| report << record_report_string(record) << "\n" }
      report << "\n\n"
      report << performers_no_songs << "\n\n"
      report.string
    end


    def record_report_string(record)
      songs = record[:songs]
      sio = StringIO.new
      sio << formatted_data_line(record[:code], record[:name], songs.first&.[](:code), songs.first&.[](:name))

      (songs[1..-1] || []).each do |song|
        sio << "\n" << formatted_data_line('', '', song[:code], song[:name])
      end
      sio.string
    end


    def performers_no_songs
      orphans = records.select { |p| p[:songs].empty? }.pluck(:name)
      return '' if orphans.empty?
      sio = StringIO.new
      sio << "The following performers do not have any songs associated with them:\n\n"
      sio << orphans.join("\n")
      sio << "\n\n"
      sio.string
    end
  end
end end
