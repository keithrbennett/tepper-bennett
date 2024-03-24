require_relative 'base_text_report'

module Reports; module TextReports
  class SongRightsAdminsTextReport < BaseTextReport

    attr_reader :records, :title, :line_length

    def initialize(records)
      @records = records
      @line_length = [Song.max_code_length, Song.max_name_length, Organization.max_code_length, Organization.max_name_length].sum + 6
      @title = 'Songs Rights Administrators'
      build_report_hash(records)
    end


    def formatted_data_line(song_code, song_name, admin_code, admin_name)
      '%-*s  %-*s  %-*s  %-*s' %
          [Song.max_code_length,      song_code,
           Song.max_name_length,      song_name,
           Organization.max_code_length, admin_code,
           Organization.max_name_length, admin_name]
    end


    def heading
      formatted_data_line('   Code', 'Name', 'Admin Code', 'Rights Administrator Name')
    end


    def report_string
      report = StringIO.new
      report << "#{title_banner}#{heading}\n\n"
      records.each { |record| report << record_report_string(record) << "\n" }
      report << "\n\n"
      report.string
    end


    def record_report_string(record)
      rights_admins = record[:rights_admins]
      sio = StringIO.new
      sio << formatted_data_line(record[:code], record[:name], rights_admins.first&.[](:code), rights_admins.first&.[](:name))

      (rights_admins[1..-1] || []).each do |rights_admin|
        sio << "\n" << formatted_data_line('', '', rights_admin[:code], rights_admin[:name])
      end
      sio.string
    end
  end
end end
