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
    headings = ['Song Code', 'Song Name', 'Perf Code', 'Performer Name']
    data = records.each_with_object([])  do |r, data|
      r[:performers].each do |p|
        data << [r[:code], r[:name], p[:code], p[:name]]
      end
    end
    html_report_table(headings, data)
  end


  def to_raw_text
    SongPerformersTextReport.new(records).report_string
  end
end
