class ReportsController < ApplicationController

  # A hash consisting of the report type (first value below) as key, Report object as value.
  def reports_metadata
    # Creates a hash whose keys are report type and values are ReportMetadata instances.
    @reports_metadata ||= [
          ['songs',               'Songs',               Reports::CodeNameReport.new(Song)],
          ['performers',          'Performers',          Reports::CodeNameReport.new(Performer)],
          ['song_plays',          'Song Plays',          Reports::SongPlaysReport.new],
          ['genres',              'Genres',              Reports::GenreReport.new],
          ['song_performers',     'Song Performers',     Reports::SongPerformersReport.new],
          ['performer_songs',     'Performer Songs',     Reports::PerformerSongsReport.new],
          ['song_genres',         'Song Genres',         Reports::SongGenresReport.new],
          ['genre_songs',         'Genre Songs',         Reports::GenreSongsReport.new],
          ['movies',              'Movies',              Reports::MovieReport.new],
          ['movie_songs',         'Movies Songs',        Reports::MovieSongsReport.new],
          ['organizations',       'Organizations',       Reports::CodeNameReport.new(Organization)],
          ['song_rights_admins',  'Song Rights Administrators', Reports::SongRightsAdminsReport.new],
          ['rights_admin_songs',  'Rights Administrator Songs', Reports::RightsAdminSongsReport.new],
          ['writers',             'Writers',             Reports::CodeNameReport.new(Writer)],
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
