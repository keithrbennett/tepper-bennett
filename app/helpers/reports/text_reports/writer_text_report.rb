require_relative 'code_name_text_report'

module Reports; module TextReports
  class WriterTextReport < CodeNameTextReport

    def initialize(records)
      super(Writer, records)
    end

  end
end end
