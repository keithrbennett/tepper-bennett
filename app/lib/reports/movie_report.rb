class MovieReport < BaseReport

  attr_reader :records, :tuples

  def initialize
    @records = pluck_to_hash(Movie.order(:name), :code, :year, :name, :imdb_key)
  end

  def to_html
    headings = ['Code', 'Year', 'IMDB Key', 'Name']
    table_data = records.map do |m|
      imdb_anchor = %Q{<a href="#{m[:imdb_url]}", target="_blank">#{m[:imdb_key]}</a>}
      %Q{<tr><td>#{m[:code]}</td><td>#{m[:year]}</td><td>#{imdb_anchor}</td><td>#{m[:name]}</td></tr>}
    end

    html_report_table(headings, table_data.join("\n"))
  end
end
