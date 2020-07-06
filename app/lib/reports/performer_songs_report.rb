class PerformerSongsReport < BaseReport

  attr_reader :records

  def initialize
    @records = Performer.order(:name).all.map do |performer|
      {
          code: performer.code,
          name: performer.name,
          songs: pluck_to_hash(performer.songs.order(:name), :code, :name)
      }
    end

    def to_html
      headings = ['Perf Code', 'Performer Name', 'Song Code', 'Song Name']
      data = records.map do |r|
        songs = r[:songs]
        [
            r[:code],
            r[:name],
            songs.pluck(:code).join("<br/>"),
            songs.pluck(:name).join("<br/>")
        ]
      end
      table_data = records_to_html_table_data(data)
      html_report_table(headings, table_data)
    end
  end
end
