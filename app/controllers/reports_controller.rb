class ReportsController < ApplicationController

  include ReportsHelper

  # A hash consisting of the report type (first value below) as key, Report object as value.
  def reports_metadata
    youtube_link_generator = ->(url) do
      render_to_string( partial: 'youtube_image_link', locals: { url: url })
    end

    @reports_metadata ||= [
          ['songs',               'Songs',               -> { CodeNameReport.new(Song).to_html } ],
          ['performers',          'Performers',          -> { CodeNameReport.new(Performer).to_html } ],
          ['song_plays',          'Song Plays',          -> { SongPlaysReport.new(youtube_link_generator).to_html }] ,
          ['genres',              'Genres',              -> { CodeNameReport.new(Genre).to_html } ],
          ['song_performers',     'Song Performers',     -> { SongPerformersReport.new.to_html } ],
          ['performer_songs',     'Performer Songs',     -> { PerformerSongsReport.new.to_html } ],
          ['song_genres',         'Genres by Song',      -> { SongGenresReport.new.to_html } ],
          ['genre_songs',         'Songs by Genre',      -> { GenreSongsReport.new.to_html } ],
          ['movies',              'Movies',              -> { MovieReport.new.to_html } ],
          ['movie_songs',         'Movies Songs',        -> { MovieSongsReport.new.to_html } ],
          ['organizations',       'Organizations',       -> { CodeNameReport.new(Organization).to_html } ],
          ['rights_admins',       'Song Rights Administrators', -> { html_rights_admins_report } ],
          ['writers',             'Writers',             -> { CodeNameReport.new(Writer).to_html } ],
      ].map { |(rpt_type, title, fn_html_report)| Report.new(rpt_type, title, fn_html_report) } \
      .each_with_object({}) { |report, report_hash| report_hash[report.rpt_type] = report }
  end


  def index
    respond_to { |format| format.html }
    render :index, layout: "application", locals: { report_metadata: reports_metadata.values }
  end


  def show
    rpt_type = params[:rpt_type]
    report_metadata = reports_metadata[rpt_type]
    locals = {
        target_rpt_format: 'html',
        html: report_metadata.fn_html_report.call
    }.merge(report_metadata.locals)

    render '/reports/report', layout: "application", locals: locals
  end

  # @param an array of field strings
  # @return the multiline string of <tr> and <td> elements.
  def records_to_html_table_data(records)
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


  # @param column_headings array of column heading strings'
  # @param table_data a multiline string of <tr> elements
  # @return a string containing the HTML for the table, including surrounding div's.
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
    table_data = records_to_html_table_data(ar_class.order(:name).pluck(:code, :name))
    html_report_table(%w{Code Name}, table_data)
  end


  class BaseReport

    attr_reader :field_names

    # # Pass array of field names as symbols
    # def initialize(field_names)
    #   @field_names = field_names
    # end

    # def to_hashes
    #   pluck(field_names)
    # end

    def preize_text(text)
      "<div><pre>\n#{text}</pre></div>\n".html_safe
    end

    def to_json
      preize_text(JSON.pretty_generate(records))
    end

    def to_yaml
      preize_text(records.to_yaml)
    end

    def to_awesome_print
      preize_text(records.ai(html: true, plain: true, multiline: true))
    end


    # @param column_headings array of column heading strings'
    # @param table_data a multiline string of <tr> elements
    # @return a string containing the HTML for the table, including surrounding div's.
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

    # @param an array of field strings
    # @return the multiline string of <tr> and <td> elements.
    def records_to_html_table_data(records)
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
  end


  class CodeNameReport < BaseReport

    attr_reader :records

    def initialize(ar_class)
      @records = ar_class.order(:name).pluck(:code, :name)
      ap @records
    end

    def to_html
      table_data = records_to_html_table_data(records)
      html_report_table(%w{Code Name}, table_data)
    end
  end


  class MovieReport < BaseReport

    attr_reader :records, :headings

    def initialize
      @records = Movie.order(:name).all.to_a
      @headings = ['Code', 'Year', 'IMDB Key', 'Name']
    end

    def to_html
      table_data = records.map do |m|
        imdb_anchor = %Q{<a href="#{m.imdb_url}", target="_blank">#{m.imdb_key}</a>}
        %Q{<tr><td>#{m.code}</td><td>#{m.year}</td><td>#{imdb_anchor}</td><td>#{m.name}</td></tr>}
      end

      html_report_table(headings, table_data.join("\n"))
    end
  end


  class MovieSongsReport < BaseReport

    attr_reader :records

    def initialize
      @records = Movie.order(:name).map do |movie|
        songs = movie.songs.order(:name)
        song_codes = songs.pluck(:code)
        song_names = songs.pluck(:name)
        {
            year: movie.year, code: movie.code, name: movie.name, song_codes: song_codes, song_names: song_names
        }
      end
    end

    def to_html
      headings = ['Year', 'Code', 'Name', 'Song Code', 'Song Name']
      html_data = records.map do |r|
        [r[:year], r[:code], r[:name], r[:song_codes].join("<br/>"), r[:song_names].join("<br/>")]
      end

      table_data = records_to_html_table_data(html_data)
      html_report_table(headings, table_data)
    end
  end


  class GenreSongsReport < BaseReport

    attr_reader :records

    def initialize
      @records = Genre.order(:name).all.map do |genre|
        {
            name: genre.name,
            songs: genre.songs.map { |s| { code: s[:code], name: s[:name] } }
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


  class SongPerformersReport < BaseReport

    attr_reader :records

    def initialize
      @records = Song.order(:name).all.map do |song|
        {
            code: song.code,
            name: song.name,
            performers: song.performers.map { |p| { code: p[:code], name: p[:name] } }
        }
      end

      def to_html
        headings = ['Song Code', 'Song Name', 'Perf Code', 'Performer Name']
        data = records.map do |r|
          [r[:code], r[:name], r[:performers].pluck(:code).join("<br/>"), r[:performers].pluck(:name).join("<br/>") ]
        end
        table_data = records_to_html_table_data(data)
        html_report_table(headings, table_data)
      end
    end
  end


  class PerformerSongsReport < BaseReport

    attr_reader :records

    def initialize
      @records = Performer.order(:name).all.map do |performer|
        {
            code: performer.code,
            name: performer.name,
            songs: performer.songs.map { |s| { code: s[:code], name: s[:name] } }
        }
      end

      def to_html
        headings = ['Perf Code', 'Performer Name', 'Song Code', 'Song Name']
        data = records.map do |r|
          songs = r[:songs]
          raise "songs is null" unless songs
          [r[:code], r[:name], songs.pluck(:code).join("<br/>"), songs.pluck(:name).join("<br/>") ]
        end
        table_data = records_to_html_table_data(data)
        html_report_table(headings, table_data)
      end
    end
  end


  class SongGenresReport < BaseReport

    attr_reader :records

    def initialize
      @records = Song.order(:name).map do |song|
        {
            code: song.code,
            name: song.name,
            genres: song.genres.pluck(:name)
        }
      end

      def to_html
        headings = ['Code', 'Name', 'Genres']
        data = records.map do |record|
          [record[:code], record[:name], record[:genres].join(', ')]
        end
        table_data = records_to_html_table_data(data)
        html_report_table(headings, table_data)
      end
    end
  end


  class SongPlaysReport < BaseReport

    attr_reader :records, :youtube_link_renderer

    def initialize(youtube_link_renderer)
      @youtube_link_renderer = youtube_link_renderer
      @records = SongPlay.joins(:song).all.order('songs.name, id').map do |song_play|
        song = song_play.song
        perfs = song_play.performers.order(:name)
        {
          song_code: song.code,
          song_name: song.name,
          performers: perfs.map { |p| { code: p.code, name: p.name } },
          youtube_key: song_play.youtube_key
        }
      end
    end

    def to_html
      headings = ['Song Code', 'Song Name', 'Perf Code', 'Performer Name', 'YouTube Key', 'Play']
      data = records.map do |r|
        performers = r[:performers]
        perf_codes = performers.map { |p| p[:code] }.join("<br/>")
        perf_names = performers.map { |p| p[:name] }.join("<br/>")
        youtube_key = r[:youtube_key]
        url = SongPlay.youtube_embed_url(youtube_key)
        youtube_link = youtube_link_renderer.(url)
        [r[:song_code], r[:song_name], perf_codes, perf_names, youtube_key, youtube_link]
      end
      table_data = records_to_html_table_data(data)
      html_report_table(headings, table_data)
    end
  end


  def html_rights_admins_report
    headings = ['Song Code', 'Song Name', 'RA Code', 'Rights Admin Name']

    data = Song.order(:name).map do |song|
      rights_admins = song.rights_admin_orgs.order(:name)
      rights_admin_codes = rights_admins.pluck(:code).join("<br/>")
      rights_admin_names = rights_admins.pluck(:name).join("<br/>")
      [song.code, song.name, rights_admin_codes, rights_admin_names]
    end

    table_data = records_to_html_table_data(data)
    html_report_table(headings, table_data)
  end
end