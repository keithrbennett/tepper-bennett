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
    headings = ['Perf Code', 'Performer Name', 'Song Code', 'Song Name']
    data = records.each_with_object([])  do |r, data|
      r[:songs].each do |s|
        data << [r[:code], r[:name], s[:code], s[:name]]
      end
    end

    html_report_table(headings, data)
  end


  def to_raw_text
    PerformerSongsTextReport.new(records).report_string
  end
end
