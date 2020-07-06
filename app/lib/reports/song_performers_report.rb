class SongPerformersReport < BaseReport

  attr_reader :records

  def initialize
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
    data = records.map do |r|
      [
          r[:code],
          r[:name],
          r[:performers].pluck(:code).join("<br/>"),
          r[:performers].pluck(:name).join("<br/>")
      ]
    end
    table_data = records_to_html_table_data(data)
    html_report_table(headings, table_data)
  end


  def to_raw_text
    SongPerformersTextReport.new(records).report_string
  end
end
