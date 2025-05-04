namespace :db do
  DATA_FILE = 'db/data.sqlite3'

  def self.data_file_stale?(data_file = DATA_FILE, verbose = true)
    unless File.exist?(data_file)
      puts 'The data file does not yet exist.'
      return true
    end

    data_mtime = File.mtime(data_file)
    source_files = (Dir['db/*.yml'] + Dir['db/migrate/*.rb'] + ['db/seeds.rb'])
    source_mtimes = source_files.each_with_object({}) do | file, time_hash|
      time_hash[file] = File.mtime(file)
    end
    newer_files = source_mtimes.each_with_object([]) do |(file, time), newer_files |
      newer_files << file if time > data_mtime
    end
    if newer_files.any?
      puts "The following files are newer than the data file:\n#{newer_files.join("\n")}"
    end
    newer_files.any?
  end

  def self.create_production_data_file!(data_file = DATA_FILE)
    system("rm -f #{data_file}")
    unless system("RAILS_ENV=production rails db:setup")
      puts "ERROR: Failed to generate production data file."
      exit(1)
    end
    File.chmod(0444, data_file) if File.exist?(data_file)
    puts "Production data file generated at #{data_file}."
  end

  desc "Generate production SQLite data file only if YAML, migration, or seeds.rb files are newer"
  task generate_production_data_file_if_stale: :environment do
    if data_file_stale?
      puts "Generating production data file because it is missing or stale..."
      create_production_data_file!
    end
  end

  desc "Check if production SQLite data file is stale and print instructions if so"
  task check_production_data_file_stale: :environment do
    if data_file_stale?
      puts "To create an up-to-date data file, please run: \033[1mrm -f db/data.sqlite3 && RAILS_ENV=production rails db:setup\033[0m"
      exit(1)
    end
  end
end 