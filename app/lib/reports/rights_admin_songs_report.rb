class RightsAdminSongsReport < BaseReport

  attr_reader :records

  def initialize
    @records = Organization.order(:name).all.map do |org|
      {
          name: org.name,
          songs: pluck_to_hash(org.songs.order(:name), :code, :name)
      }
    end
  end

  def to_html
    html = StringIO.new
    headings = ['RA Code', 'Rights Administrator Name']

    append_row = ->(org) do
      html << "<h2>Rights Administrator &mdash; #{org[:name]}</h2>\n"
      songs = org[:songs]
      if songs.empty?
        html << "[No songs for this rights administrator.]</br>\n"
      else
        data = org[:songs].map { |song| [song[:code], song[:name]] }
        table_data = records_to_html_table_data(data)
        html << "<br/>\n" << html_report_table(headings, table_data)
      end
      html << "<br/><br/>\n"
    end

    records.each { |org| append_row.(org) }
    html.string.html_safe
  end


  def to_raw_text
    RightsAdminSongsTextReport.new(records).report_string
  end


end