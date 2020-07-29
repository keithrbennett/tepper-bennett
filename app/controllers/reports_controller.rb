class ReportsController < ApplicationController

  include ReportsHelper

  # A hash consisting of the report type (first value below) as key, Report object as value.
  def reports_metadata
    youtube_link_generator = ->(url) do
      render_to_string( partial: 'youtube_image_link', locals: { url: url })
    end

    @reports_metadata ||= [
          ['songs',               'Songs',               CodeNameReport.new(Song)],
          ['performers',          'Performers',          CodeNameReport.new(Performer)],
          ['song_plays',          'Song Plays',          SongPlaysReport.new(youtube_link_generator)],
          ['genres',              'Genres',              GenreReport.new],
          ['song_performers',     'Song Performers',     SongPerformersReport.new],
          ['performer_songs',     'Performer Songs',     PerformerSongsReport.new],
          ['song_genres',         'Song Genres',         SongGenresReport.new],
          ['genre_songs',         'Genre Songs',         GenreSongsReport.new],
          ['movies',              'Movies',              MovieReport.new],
          ['movie_songs',         'Movies Songs',        MovieSongsReport.new],
          ['organizations',       'Organizations',       CodeNameReport.new(Organization)],
          ['song_rights_admins',  'Song Rights Administrators', SongRightsAdminsReport.new],
          ['rights_admin_songs',  'Rights Administrator Songs', RightsAdminSongsReport.new],
          ['writers',             'Writers',             CodeNameReport.new(Writer)],
      ].map { |(rpt_type, title, report)| ReportMetadata.new(rpt_type, title, report) } \
      .each_with_object({}) { |report, report_hash| report_hash[report.rpt_type] = report }
  end


  def index
    respond_to { |format| format.html }
    render :index, layout: "application", locals: { report_metadata: reports_metadata.values }
  end


  def show
    # The route is "get 'reports/:rpt_type', to: 'reports#show'" so the report type
    # is accessed as a parameter.
    rpt_type = params[:rpt_type]
    report_metadata = reports_metadata[rpt_type]
    report = report_metadata.report
    report.populate
    locals = {
        target_rpt_format: 'html',
        report: report,
    }.merge(report_metadata.locals)

    render '/reports/report', layout: "application", locals: locals
  end
end









