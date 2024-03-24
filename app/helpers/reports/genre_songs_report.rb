module Reports
  class GenreSongsReport < BaseReport

    attr_reader :records

    def initialize
      @title = 'Genre Songs'
      @report_type = 'genre_songs'
    end

    def populate
      @records = Genre.order(:name).all.map do |genre|
        {
            name: genre.name,
            songs: pluck_to_hash(genre.songs.order(:name), :code, :name)
        }
      end
    end

    def to_html
      render partial: 'reports/genre_songs', locals: { records: records }
    end

    def to_raw_text
      GenreSongsTextReport.new(records).report_string
    end
  end
end
