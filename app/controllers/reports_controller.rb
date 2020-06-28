class ReportsController < ApplicationController

  include ReportsHelper

  def index
    init_reports_metadata
    respond_to { |format| format.html }
    render :index, layout: "application"
  end


  def init_reports_metadata
    @reports ||= [
        ['song_codes_names',          'Songs',             html_code_name_report_table(Song)],
        ['performer_codes_names',     'Performers',        html_code_name_report_table(Performer)],
        ['song_plays',                'Song Plays',        html_song_plays_report],
        ['genres',                    'Genres',            html_code_name_report_table(Genre)],
        ['song_performers',           'Song Performers',   html_song_performers_report],
        ['performer_songs',           'Performer Songs',   html_performer_songs_report],
        ['song_genres',               'Genres by Song',    html_song_genres_report],
        ['genre_songs',               'Songs by Genre',    html_genre_songs_report],
        ['movies',                    'Movies',            html_movie_report],
        ['movie_songs',               'Movies Songs',      html_movie_songs_report],
        ['organization_codes_names',  'Organizations',     html_code_name_report_table(Organization)],
        ['song_rights_admins', 'Song Rights Administrators', html_rights_admins_report],
        ['writer_codes_names',        'Writers',           html_code_name_report_table(Writer)],
    ].map { |(key, title, html_report)| Report.new(key, title, html_report) }
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
          render_to_string('layouts/_youtube_image_link', locals: { url: song_play.youtube_embed_url })
      ]
    end

    table_data = records_to_cell_data(data)
    html_report_table(headings, table_data)
  end

end