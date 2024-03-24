module Reports; module TextReports
  class HasManyTextReport < BaseTextReport

    attr_reader :records, :primary_ar_class, :secondary_ar_class, :title

    def initialize(records, title, primary_ar_class, secondary_ar_class)
      @records = records
      @title = title
      @primary_ar_class = primary_ar_class
      @secondary_ar_class = secondary_ar_class
      build_report_hash(records)
    end


    def line_length
      secondary_ar_class.max_code_length + secondary_ar_class.max_name_length + 2
    end


    def report_string
      report = StringIO.new

      report << title_banner
      records.each_with_index do |primary, index|
        (report << separator_line << "\n") unless index == 0 # omit '----' on first section
        report << "#{primary_ar_class.name.capitalize}: #{primary[:name]}\n\n"
        report << record_report_string(primary[:songs]) << "\n"
      end
      report << "\n\n"
      report.string
    end


    def record_report_string(secondaries)
      sio = StringIO.new
      if secondaries.empty?
        sio << "[None]\n"
      else
        secondaries.each do |record|
          sio << ("%-*s  %-s\n" %
              [secondary_ar_class.max_code_length, record[:code], record[:name]])
        end
      end

      sio.string
    end
  end
end end
