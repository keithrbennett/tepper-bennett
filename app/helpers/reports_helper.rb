require_relative 'report'

module ReportsHelper


  def self.records_to_cell_data(records)
    html = StringIO.new
    html << "\n"
    records.each do |record|
      html << "<tr>"
      record.each do |field_value|
        html << "<td>" << field_value << "</td>"
      end
      html << "</tr>\n"
    end
    html.string.html_safe
  end


  def self.html_report_table(column_headings, table_data)

    html = <<HEREDOC
    <div class="table-responsive">
    <table class="table thead-dark table-striped">
    <thead class="thead-dark">
      <tr>#{column_headings.map { |h| "<th>#{h}</th>"}.join}</tr>
    </thead>
    #{table_data}
    </table>
    </div>
HEREDOC
    html.html_safe
  end


  def self.html_code_name_report_table(ar_class)
    table_data = records_to_cell_data(ar_class.order(:name).pluck(:code, :name))
    html_report_table(%w{Code Name}, table_data)
  end


  def self.movie_report
    headings = ['Code', 'Year', 'IMDB Key', 'Name']
    table_data = Movie.order(:name).map do |m|
      imdb_anchor = %Q{<a href="#{m.imdb_url}", target="_blank">#{m.imdb_key}</a>}
      %Q{<tr><td>#{m.code}</td><td>#{m.year}</td><td>#{imdb_anchor}</td><td>#{m.name}</td></tr>}
    end

    html_report_table(headings, table_data.join("\n"))
  end


  def self.rights_admins_report
    headings = ['Song Code', 'Song Name', 'RA Code', 'Rights Admin Name']
    data = Song.order(:name).map do |song|
      rights_admin = song.rights_admin_orgs.order(:name).first
      rights_admin_code = rights_admin ? rights_admin.code : '?'
      rights_admin_name = rights_admin ? rights_admin.name : '?'
      [song.code, song.name, rights_admin_code, rights_admin_name]
    end

    table_data = records_to_cell_data(data)
    html_report_table(headings, table_data)
  end


  def self.init_reports_metadata
    sample_html_report = '<h1>Sample</h1>'

    @reports ||= [
        ['song_codes_names',          'Songs',             html_code_name_report_table(Song)],
        ['performer_codes_names',     'Performers',        html_code_name_report_table(Performer)],
        ['genres',                    'Genres',            html_code_name_report_table(Genre)],
        ['song_performers',           'Song Performers',   sample_html_report],
        ['performer_songs',           'Performer Songs',   sample_html_report],
        ['song_genres',               'Genres by Song',    sample_html_report],
        ['genre_songs',               'Songs by Genre',    sample_html_report],
        ['movies',                    'Movies',            movie_report],
        ['movie_songs',               'Movies Songs',      sample_html_report],
        ['organization_codes_names',  'Organizations',     html_code_name_report_table(Organization)],
        ['song_rights_admins',        'Song Rights Administrators', rights_admins_report],
        ['writer_codes_names',        'Writers',           html_code_name_report_table(Writer)],
    ].map { |(key, title, html_report)| Report.new(key, title, html_report) }
  end



end
