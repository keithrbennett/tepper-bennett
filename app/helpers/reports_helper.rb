require_relative 'report'

module ReportsHelper

  def self.html_report_table(ar_class)

    html = <<HEREDOC
    <div class="table-responsive">
    <table class="table thead-dark table-striped">
    <thead class="thead-dark">
      <tr>
        <th>Code</th>
        <th>Name</th>
      </tr>
    </thead>
    #{html_report_data(ar_class)}
    </table>
    </div>
HEREDOC
    html.html_safe
  end


  def self.html_report_data(ar_class)
    ar_class.order(:name).map do |obj|
      "<tr><td>#{obj.code}</td><td>#{obj.name}</td></tr>"
    end.join("\n").html_safe
  end


  def self.init_reports_metadata
    sample_html_report = '<h1>Sample</h1>'

    @reports ||= [
        ['song_codes_names',          'Songs',             html_report_table(Song)],
        ['performer_codes_names',     'Performers',        html_report_table(Performer)],
        ['genres',                    'Genres',            html_report_table(Genre)],
        ['song_performers',           'Song Performers',   sample_html_report],
        ['performer_songs',           'Performer Songs',   sample_html_report],
        ['song_genres',               'Genres by Song',    sample_html_report],
        ['genre_songs',               'Songs by Genre',    sample_html_report],
        ['movies',                    'Movies',            sample_html_report],
        ['movie_songs',               'Movies Songs',      sample_html_report],
        ['organization_codes_names',  'Organizations',     html_report_table(Organization)],
        ['song_rights_admins',        'Song Rights Administrators', sample_html_report],
        ['writer_codes_names',        'Writers',           html_report_table(Writer)],
    ].map { |(key, title, html_report)| Report.new(key, title, html_report) }
  end



end
