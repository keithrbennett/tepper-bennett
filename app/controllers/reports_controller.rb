class ReportsController < ApplicationController

  include ReportsHelper

  # A hash consisting of the report type (first value below) as key, Report object as value.
  REPORT_METADATA = [
          ['songs',               'Songs',               -> { html_code_name_report_table(Song) } ],
          ['performers',          'Performers',          -> { html_code_name_report_table(Performer) } ],
          ['song_plays',          'Song Plays',          -> { html_song_plays_report }] ,
          ['genres',              'Genres',              -> { html_code_name_report_table(Genre) } ],
          ['song_performers',     'Song Performers',     -> { html_song_performers_report } ],
          ['performer_songs',     'Performer Songs',     -> { html_performer_songs_report } ],
          ['song_genres',         'Genres by Song',      -> { html_song_genres_report } ],
          ['genre_songs',         'Songs by Genre',      -> { html_genre_songs_report } ],
          ['movies',              'Movies',              -> { html_code_name_report_table(Movie) } ],
          ['movie_songs',         'Movies Songs',        -> { html_movie_songs_report } ],
          ['organizations',       'Organizations',       -> { html_code_name_report_table(Organization) } ],
          ['rights_admins',       'Song Rights Administrators', -> { html_rights_admins_report } ],
          ['writers',             'Writers',             -> { html_code_name_report_table(Writer) } ],
      ].map { |(rpt_type, title, fn_html_report)| Report.new(rpt_type, title, fn_html_report) } \
      .each_with_object({}) { |report, report_hash| report_hash[report.rpt_type] = report }

  def index
    respond_to { |format| format.html }
    render :index, layout: "application", locals: { report_metadata: REPORT_METADATA.values }
  end


  def report_action(rpt_type, html_text)
    locals = {
        target_rpt_format: 'html',
        html: html_text,
    }.merge(REPORT_METADATA[rpt_type].locals)

    render '/reports/report', layout: "application", locals: locals
  end


  def songs
    report_action('songs', html_code_name_report_table(Song))
  end

  def performers
    report_action('performers', html_code_name_report_table(Performer))
  end

  def song_plays
    report_action('song_plays', html_song_plays_report)
  end

  def genres
    report_action('genres', html_code_name_report_table(Genre))
  end

  def song_performers
    report_action('song_performers', html_song_performers_report)
  end

  def performer_songs
    report_action('performer_songs', html_performer_songs_report)
  end

  def song_genres
    report_action('song_genres', html_song_genres_report)
  end

  def genre_songs
    report_action('genre_songs', html_genre_songs_report)
  end

  def movies
    report_action('movies', html_code_name_report_table(Movie))
  end

  def movie_songs
    report_action('movie_songs', html_movie_songs_report)
  end

  def organizations
    report_action('organizations', html_code_name_report_table(Organization))
  end

  def rights_admins
    report_action('rights_admins', html_rights_admins_report)
  end

  def writers
    report_action('writers', html_code_name_report_table(Writer))
  end


  def records_to_cell_data(records)
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


  def html_report_table(column_headings, table_data)

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


  def html_code_name_report_table(ar_class)
    table_data = records_to_cell_data(ar_class.order(:name).pluck(:code, :name))
    html_report_table(%w{Code Name}, table_data)
  end


  def html_movie_report
    headings = ['Code', 'Year', 'IMDB Key', 'Name']
    table_data = Movie.order(:name).map do |m|
      imdb_anchor = %Q{<a href="#{m.imdb_url}", target="_blank">#{m.imdb_key}</a>}
      %Q{<tr><td>#{m.code}</td><td>#{m.year}</td><td>#{imdb_anchor}</td><td>#{m.name}</td></tr>}
    end

    html_report_table(headings, table_data.join("\n"))
  end


  def html_rights_admins_report
    headings = ['Song Code', 'Song Name', 'RA Code', 'Rights Admin Name']

    data = Song.order(:name).map do |song|
      rights_admins = song.rights_admin_orgs.order(:name)
      rights_admin_codes = rights_admins.pluck(:code).join("<br/>")
      rights_admin_names = rights_admins.pluck(:name).join("<br/>")
      [song.code, song.name, rights_admin_codes, rights_admin_names]
    end

    table_data = records_to_cell_data(data)
    html_report_table(headings, table_data)
  end


  def html_movie_songs_report
    headings = ['Year', 'Code', 'Name', 'Song Code', 'Song Name']

    data = Movie.order(:name).map do |movie|
      songs = movie.songs.order(:name)
      song_codes = songs.pluck(:code).join("<br/>")
      song_names = songs.pluck(:name).join("<br/>")
      [movie.year, movie.code, movie.name, song_codes, song_names]
    end

    table_data = records_to_cell_data(data)
    html_report_table(headings, table_data)
  end


  def html_genre_songs_report
    html = StringIO.new
    headings = ['Song Code', 'Song Name']

    Genre.order(:name).all.each do |genre|
      html << "<h2>Genre &mdash; #{genre.name}</h2>\n"
      songs = genre.songs
      if songs.empty?
        html << "[No songs for this genre]</br>\n"
      else
        data = genre.songs.map { |song| [song.code, song.name]}
        table_data = records_to_cell_data(data)
        html << "<br/>\n" << html_report_table(headings, table_data)
      end
      html << "<br/><br/>\n"
    end
    html.string.html_safe
  end


  def html_song_performers_report
    headings = ['Song Code', 'Song Name', 'Perf Code', 'Performer Name']
    data = Song.order(:name).map do |song|
      [
          song.code,
          song.name,
          song.performers.pluck(:code).join("<br/>"),
          song.performers.pluck(:name).join("<br/>"),
      ]
    end

    table_data = records_to_cell_data(data)
    html_report_table(headings, table_data)
  end


  def html_performer_songs_report
    headings = ['Perf Code', 'Performer Name', 'Song Code', 'Song Name']
    data = Performer.order(:name).map do |performer|
      [
          performer.code,
          performer.name,
          performer.songs.pluck(:code).join("<br/>"),
          performer.songs.pluck(:name).join("<br/>"),
      ]
    end

    table_data = records_to_cell_data(data)
    html_report_table(headings, table_data)
  end


  def html_song_genres_report
    headings = ['Code', 'Name', 'Genres']
    data = Song.order(:name).map do |song|
      [
          song.code,
          song.name,
          song.genres.pluck(:name).join(", "),
      ]
    end

    table_data = records_to_cell_data(data)
    html_report_table(headings, table_data)
  end


  def html_song_plays_report
    headings = ['Song Code', 'Song Name', 'Perf Code', 'Performer Name', 'YouTube Key', 'Play']
    data = SongPlay.joins(:song).all.order('songs.name, id').map do |song_play|
      song = song_play.song
      perfs = song_play.performers.order(:name)
      [
          song.code,
          song.name,
          perfs.pluck(:code).join("\n"),
          perfs.pluck(:name).join("\n"),
          song_play.youtube_key,
          render_to_string( partial: 'youtube_image_link', locals: { url: song_play.youtube_embed_url })
      ]
    end

    table_data = records_to_cell_data(data)
    html_report_table(headings, table_data)
  end
end