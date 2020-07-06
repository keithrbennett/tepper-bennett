Dir[File.join(Rails.root, 'app', 'lib', 'reports', '*.rb')].each { |file| puts file; require file }

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
  # def records_to_html_table_data(records)
  #   html = StringIO.new
  #   html << "\n"
  #   records.each do |record|
  #     html << "<tr>"
  #     record.each do |field_value|
  #       html << "<td>" << field_value << "</td>"
  #     end
  #     html << "</tr>\n"
  #   end
  #   html.string.html_safe
  # end
  #
  #
  # @param column_headings array of column heading strings'
  # @param table_data a multiline string of <tr> elements
  # @return a string containing the HTML for the table, including surrounding div's.
  # def html_report_table(column_headings, table_data)
  #
  #   html = <<HEREDOC
  #   <div class="table-responsive">
  #   <table class="table thead-dark table-striped">
  #   <thead class="thead-dark">
  #     <tr>#{column_headings.map { |h| "<th>#{h}</th>"}.join}</tr>
  #   </thead>
  #   {table_data}
    # </table>
    # </div>
# HEREDOC
#     html.html_safe
#   end


end









