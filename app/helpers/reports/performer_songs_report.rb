module Reports
  class PerformerSongsReport < BaseReport

    attr_reader :records

    def initialize
      @report_type = 'performer_songs'
    end

    def populate
      @records = Performer.order(:name).all.map do |performer|
        {
            code: performer.code,
            name: performer.name,
            songs: pluck_to_hash(performer.songs.order(:name), :code, :name)
        }
      end
    end

    def to_html
      render(partial: 'reports/performer_songs', locals: { records: records })
    end


    def to_raw_text
      PerformerSongsTextReport.new(records).report_string
    end
  end
end
