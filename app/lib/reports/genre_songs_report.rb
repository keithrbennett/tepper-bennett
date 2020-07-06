class GenreSongsReport < BaseReport

  attr_reader :records

  def initialize
    @records = Genre.order(:name).all.map do |genre|
      {
          name: genre.name,
          songs: pluck_to_hash(genre.songs.order(:name), :code, :name)
      }
    end
  end

  def to_html
    html = StringIO.new
    headings = ['Song Code', 'Song Name']

    append_row = ->(genre) do
      html << "<h2>Genre &mdash; #{genre[:name]}</h2>\n"
      songs = genre[:songs]
      if songs.empty?
        html << "[No songs for this genre]</br>\n"
      else
        data = genre[:songs].map { |song| [song[:code], song[:name]] }
        table_data = records_to_html_table_data(data)
        html << "<br/>\n" << html_report_table(headings, table_data)
      end
      html << "<br/><br/>\n"
    end

    records.each { |genre| append_row.(genre) }
    html.string.html_safe
  end
end
