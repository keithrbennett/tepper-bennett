require_relative '../../config/environment'

namespace :reports do

  # Would this be shared by other files? (Bad if so.)
  DEFINED_TASKS = []

  def gen_task(task_type)
    desc "Generates a list of #{task_type}"
    task_name = task_type.to_s + '_codes_names'
    task task_name do
      klass = Kernel.const_get("Report" + task_type.to_s.capitalize[0..-2] + 'CodesNames')
      puts klass.new.report_string
    end

    DEFINED_TASKS << task_name
  end


  %i(genres writers movies performers organizations songs).each { |task_type| gen_task(task_type) }


  desc 'List song information'
  task :songs do
    puts ReportSongs.new.report_string
  end
  DEFINED_TASKS << :songs


  desc 'Report song genres'
  task :song_genres do
    puts ReportSongGenres.new.report_string
  end
  DEFINED_TASKS << :song_genres


  desc 'List songs of each genre'
  task :genre_songs do
    puts ReportGenreSongs.new.report_string
  end
  DEFINED_TASKS << :genre_songs


  task all: DEFINED_TASKS

end