require_relative '../../config/environment'

namespace :reports do

  # Would this be shared by other files? (Bad if so.)
  DEFINED_TASKS = []


  def write_report(task_name, format, report_text)  # format in %i[txt json yaml]
    filespec = File.join(Rails.root, 'app', 'generated_reports', "#{task_name}_report.#{format}")
    puts "Writing #{task_name} report to #{filespec}..."
    File.write(filespec, report_text)
  end


  def gen_code_name_report_task(task_type)
    desc "Generates a list of codes and names for #{task_type}s"
    task_name = task_type.to_s + '_codes_names'
    task task_name do
      klass = Kernel.const_get("Report" + task_type.to_s.capitalize + 'CodesNames')
      reporter = klass.new
      write_report(task_name, :txt,  reporter.to_text)
      write_report(task_name, :json, reporter.to_json)
      write_report(task_name, :yaml, reporter.to_yaml)
    end

    DEFINED_TASKS << task_name
  end

  def gen_report_task(task_name, report_class, description)
    desc description
    task task_name do
      reporter = report_class.new
      write_report(task_name, :txt, reporter.report_string)
      if %i(genres  genre_songs  movie_songs  movies  performer_songs  song_genres).include?(task_name)
        write_report(task_name, :json, reporter.to_json)
        write_report(task_name, :yaml, reporter.to_yaml)
      end
    end
    DEFINED_TASKS << task_name
  end


  %i(writer performer organization song).each { |task_type| gen_code_name_report_task(task_type) }


  gen_report_task(:song_rights_admins, ReportSongRightsAdmins, 'List rights administrator(s) for each song')
  gen_report_task(:song_performers,    ReportSongPerformers,   'List songs and their performers')
  gen_report_task(:performer_songs,    ReportPerformerSongs,   'List performers and their songs')
  gen_report_task(:song_plays,         ReportSongPlays,        'List song plays (YouTube)')
  gen_report_task(:genres,             ReportGenres,           'List genres')
  gen_report_task(:song_genres,        ReportSongGenres,       'List song genres')
  gen_report_task(:genre_songs,        ReportGenreSongs,       'List songs of each genre')
  gen_report_task(:movies,             ReportMovies,           'List movies and their IMDB keys')
  gen_report_task(:movie_songs,        ReportMovieSongs,       'List movies and their songs')


  task all: DEFINED_TASKS

end