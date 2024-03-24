module Reports
  class SongGenresReport < BaseReport

    attr_reader :records

    def initialize
      @report_type = 'song_genres'
    end

    def populate
      @records = Song.order(:name).map do |song|
        {
            code: song.code,
            name: song.name,
            genres: song.genres.order(:name).pluck(:name)
        }
      end
    end

    def to_html
      headings = ['Code', 'Name', 'Genres']
      data = records.map do |record|
        [record[:code], record[:name], record[:genres].join(', ')]
      end
      locals = { table_id: 'song-genres-report-table', column_headings: headings, records: data }
      render partial: 'reports/report_table', locals: locals
    end


    def to_raw_text
      SongGenresTextReport.new(records).report_string
    end
  end
end

