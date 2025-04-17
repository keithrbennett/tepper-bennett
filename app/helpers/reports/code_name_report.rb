module Reports
  class CodeNameReport < BaseReport

    attr_reader :ar_class, :records, :report_type, :tuples

    def initialize(ar_class)
      @ar_class = ar_class
      @report_type = ar_class.name.underscore.pluralize
    end

    def populate
      @tuples = ar_class.order(:name).pluck(:code, :name)
      @records = tuples.map do |tuple|
        { code: tuple[0], name: tuple[1] }
      end
    end

    def to_html
      locals = { table_id: "#{ar_class.name.downcase}-report-table", column_headings: %w{Code Name}, records: tuples }
      render partial: 'reports/report_table', locals: locals
    end

    def to_raw_text
      TextReports::CodeNameTextReport.new(ar_class, records).report_string
    end
  end
end
