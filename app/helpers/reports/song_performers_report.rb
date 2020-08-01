class SongPerformersReport < BaseReport

  attr_reader :records

  def initialize
    @report_type = 'song_performers'
  end

  def populate
    @records = Song.order(:name).all.map do |song|
      {
          code: song.code,
          name: song.name,
          performers: pluck_to_hash(song.performers.order(:name), :code, :name)
      }
    end
  end

  def to_html
    render(partial: 'reports/song_performers', locals: { records: records })
  end


  def to_raw_text
    SongPerformersTextReport.new(records).report_string
  end
end
