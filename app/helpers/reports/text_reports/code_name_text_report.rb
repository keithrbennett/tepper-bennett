require_relative 'base_text_report'

module Reports; module TextReports

  # Produces a report string containing the codes and names for the specified ActiveRecord class.
  class CodeNameTextReport < BaseTextReport

    attr_reader :ar_class, :title, :records

    def initialize(ar_class, records)
      @ar_class = ar_class
      @title = ar_class.name.capitalize.pluralize
      @records = records
      build_report_hash(records)
    end


    def line_length
      ar_class.max_code_length + ar_class.max_name_length + 2
    end


    def report_string
      report = StringIO.new
      report << title_banner << "   Code           Name\n\n"
      @report_data['data'].each { |record| report << record_report_string(record) << "\n" }
      report << "\n\n"
      report.string
    end


    def record_report_string(record)
      '%-14s %s' % [record[:code], record[:name]]
    end
  end
end end
