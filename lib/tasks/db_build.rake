namespace :db do
  DATA_FILE = 'db/data.sqlite3'

  def self.data_file_stale?(data_file = DATA_FILE)
    return true unless File.exist?(data_file)
    
    latest_source_mtime = \
      (Dir['db/*.yml'] + Dir['db/migrate/*.rb'] + ['db/seeds.rb']) \
      .map { |f| File.exist?(f) ? File.mtime(f) : Time.at(0) } \
      .max
    data_mtime = File.mtime(data_file)
    latest_source_mtime > data_mtime
  end

  def self.create_production_data_file!(data_file = DATA_FILE)
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
    else
      puts "#{DATA_FILE} is up to date. No action taken."
    end
  end

  desc "Check if production SQLite data file is stale and print instructions if so"
  task check_production_data_file_stale: :environment do
    if data_file_stale?
      puts "WARNING: #{DATA_FILE} is stale (a migration, YAML, or seeds.rb file is newer)."
      puts "Please run: RAILS_ENV=production rails db:setup"
      exit(1)
    else
      puts "#{DATA_FILE} is up to date."
    end
  end
end 