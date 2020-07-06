class ReportsController < ApplicationController

  include ReportsHelper

  # A hash consisting of the report type (first value below) as key, Report object as value.
  def reports_metadata
    youtube_link_generator = ->(url) do
      render_to_string( partial: 'youtube_image_link', locals: { url: url })
    end

    @reports_metadata ||= [
          ['songs',               'Songs',               -> { CodeNameReport.new(Song) } ],
          ['performers',          'Performers',          -> { CodeNameReport.new(Performer) } ],
          ['song_plays',          'Song Plays',          -> { SongPlaysReport.new(youtube_link_generator) }] ,
          ['genres',              'Genres',              -> { CodeNameReport.new(Genre) } ],
          ['song_performers',     'Song Performers',     -> { SongPerformersReport.new } ],
          ['performer_songs',     'Performer Songs',     -> { PerformerSongsReport.new } ],
          ['song_genres',         'Genres by Song',      -> { SongGenresReport.new } ],
          ['genre_songs',         'Songs by Genre',      -> { GenreSongsReport.new } ],
          ['movies',              'Movies',              -> { MovieReport.new } ],
          ['movie_songs',         'Movies Songs',        -> { MovieSongsReport.new } ],
          ['organizations',       'Organizations',       -> { CodeNameReport.new(Organization) } ],
          ['rights_admins',       'Song Rights Administrators', -> { RightsAdminReport.new } ],
          ['writers',             'Writers',             -> { CodeNameReport.new(Writer) } ],
      ].map { |(rpt_type, title, fn_report)| ReportMetadata.new(rpt_type, title, fn_report) } \
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
        report: report_metadata.fn_report.call,
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


  class BaseReport

    attr_reader :field_names

    VALID_FORMATS = %w(html text json yaml)

    def content(rpt_format)
      unless VALID_FORMATS.include?(rpt_format)
        raise "Invalid format (#{rpt_format}); must be one of #{VALID_FORMATS.join(', ')}"
      end
      case rpt_format
      when 'html'
        to_html
      when 'text'
        to_text
      when 'json'
        to_json
      when 'yaml'
        to_yaml
      end
    end

    def preize_text(text)
      "<div><pre>\n#{text}</pre></div>\n".html_safe
    end

    def to_text
      to_yaml # TODO: Change this to real text report
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


    def pluck_to_hash(ar_relation, *field_names)
      ar_relation.pluck(*field_names).map do |field_values|
        field_names.zip(field_values).each_with_object({}) do |(key, value), result_hash|
          result_hash[key] = value
        end
      end
    end
  end


  class CodeNameReport < BaseReport

    attr_reader :records, :tuples

    def initialize(ar_class)
      @tuples = ar_class.order(:name).pluck(:code, :name)
      @records = tuples.map do |tuple|
        { code: tuple[0], name: tuple[1] }
      end
    end

    def to_html
      table_data = records_to_html_table_data(tuples)
      html_report_table(%w{Code Name}, table_data)
    end
  end


  class MovieReport < BaseReport

    attr_reader :records, :tuples

    def initialize
      @records = pluck_to_hash(Movie.order(:name), :code, :year, :name, :imdb_key)
      ap records
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


  class MovieSongsReport < BaseReport

    attr_reader :records

    def initialize
      @records = Movie.order(:name).map do |movie|
        songs = pluck_to_hash(movie.songs.order(:name), :code, :name)
        { year: movie.year, code: movie.code, name: movie.name, songs: songs }
      end
    end

    def to_html
      headings = ['Year', 'Code', 'Name', 'Song Code', 'Song Name']
      html_data = records.map do |r|
        [
            r[:year],
            r[:code],
            r[:name],
            r[:songs].pluck(:code).join('<br/>') ,
            r[:songs].pluck(:name).join('<br/>') ,
        ]
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


  class SongPerformersReport < BaseReport

    attr_reader :records

    def initialize
      @records = Song.order(:name).all.map do |song|
        {
            code: song.code,
            name: song.name,
            performers: pluck_to_hash(song.performers.order(:name), :code, :name)
        }
      end

      def to_html
        headings = ['Song Code', 'Song Name', 'Perf Code', 'Performer Name']
        data = records.map do |r|
          [
              r[:code],
              r[:name],
              r[:performers].pluck(:code).join("<br/>"),
              r[:performers].pluck(:name).join("<br/>")
          ]
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


  class SongGenresReport < BaseReport

    attr_reader :records

    def initialize
      @records = Song.order(:name).map do |song|
        {
            code: song.code,
            name: song.name,
            genres: song.genres.order(:name).pluck(:name)
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
          performers: pluck_to_hash(perfs, :code, :name),
          youtube_key: song_play.youtube_key
        }
      end
    end

    def to_html
      headings = ['Song Code', 'Song Name', 'Perf Code', 'Performer Name', 'YouTube Key', 'Play']
      data = records.map do |r|
        performers = r[:performers]
        youtube_key = r[:youtube_key]
        url = SongPlay.youtube_embed_url(youtube_key)
        youtube_link = youtube_link_renderer.(url)
        [
            r[:song_code],
            r[:song_name],
            performers.pluck(:code).join("<br/>"),
            performers.pluck(:name).join("<br/>"),
            youtube_key,
            youtube_link]
      end
      table_data = records_to_html_table_data(data)
      html_report_table(headings, table_data)
    end
  end


  class RightsAdminReport < BaseReport

    attr_reader :records

    def initialize
      @records = Song.order(:name).map do |song|
        rights_admins = song.rights_admin_orgs.order(:name)
        {
            code: song.code,
            name: song.name,
            rights_admins: pluck_to_hash(rights_admins, :code, :name),
        }
      end
      ap records
    end


    def to_html
      headings = ['Song Code', 'Song Name', 'RA Code', 'Rights Admin Name']
      html_data = records.map do |r|
        [
            r[:code],
            r[:name],
            r[:rights_admins].pluck(:code).join("<br/>"),
            r[:rights_admins].pluck(:name).join("<br/>"),
        ]
      end
      table_data = records_to_html_table_data(html_data)
      html_report_table(headings, table_data)
    end
  end
end