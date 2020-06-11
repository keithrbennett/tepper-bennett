require_relative '../../config/environment'

namespace :reports do

  # Would this be shared by other files? (Bad if so.)
  DEFINED_TASKS = []


  def write_report(task_name, report_text)
    filespec = File.join(Rails.root, 'outputs', "#{task_name}_report.txt")
    puts "Writing #{task_name} report to #{filespec}..."
    File.write(filespec, report_text)
  end


  def gen_code_name_report_task(task_type)
    desc "Generates a list of codes and names for #{task_type}s"
    task_name = task_type.to_s + '_codes_names'
    task task_name do
      klass = Kernel.const_get("Report" + task_type.to_s.capitalize + 'CodesNames')
      write_report(task_name, klass.new.report_string)
    end

    DEFINED_TASKS << task_name
  end

  def gen_report_task(task_name, report_class, description)
    desc description
    task task_name do
      write_report(task_name, report_class.new.report_string)
    end
    DEFINED_TASKS << task_name
  end


  %i(genre writer performer organization song).each { |task_type| gen_code_name_report_task(task_type) }


  gen_report_task(:song_rights_admins, ReportSongRightsAdmins, 'List rights administrator(s) for each song')
  gen_report_task(:song_performers,    ReportSongPerformers,   'List song information')
  gen_report_task(:song_genres,        ReportSongGenres,       'Report song genres')
  gen_report_task(:genre_songs,        ReportGenreSongs,       'List songs of each genre')
  gen_report_task(:movies,             ReportMovies,           'List movies')
  gen_report_task(:movie_songs,        ReportMovieSongs,       'List songs for each movie')


  task all: DEFINED_TASKS

end