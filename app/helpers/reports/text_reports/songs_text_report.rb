require_relative 'code_name_text_report'

module Reports; module TextReports
  class SongsTextReport < CodeNameTextReport

    def initialize(records)
      super(Song, records)
    end

  end
end end
