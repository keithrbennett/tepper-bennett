require_relative 'base_text_report'

module Reports; module TextReports
  class GenreTextReport < BaseTextReport

    attr_reader :records, :title, :line_length

    def initialize(records)
      @records = records
      @line_length = [Genre.max_code_length, Genre.max_name_length].sum + 11
      @title = 'Genres'
      build_report_hash(records)
    end


    def formatted_data_line(code, name, count)
      '%-*s  %-*s  %s' % [
          Genre.max_code_length, code,
          Genre.max_name_length, name,
          count
      ]
    end


    def heading
      formatted_data_line('   Code', 'Name','Song Count')
    end


    def report_string
      report = StringIO.new
      report << title_banner << "#{heading}\n\n"
      records.each { |record| report << record_report_string(record) << "\n" }
      report << "\n\n"
      report.string
    end


    def record_report_string(record)
      formatted_data_line(record[:code], record[:name], ('%8d' % record[:song_count]))
    end
  end
end end
