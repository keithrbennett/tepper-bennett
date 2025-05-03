namespace :db do
  def self.data_file_stale?(data_file)
    return true unless File.exist?(data_file)

    files = Dir['db/*.yml'] + Dir['db/migrate/*.rb'] + ['db/seeds.rb']
    latest_source_mtime = files.map { |f| File.exist?(f) ? File.mtime(f) : Time.at(0) }.max
    data_mtime = File.mtime(data_file)
    latest_source_mtime > data_mtime
  end

  desc "Generate production SQLite data file only if YAML, migration, or seeds.rb files are newer"
  task generate_production_data_file_if_stale: :environment do
    data_file = 'db/data.sqlite3'

    if data_file_stale?(data_file)
      puts "Generating production data file because it is missing or stale..."
      unless system("RAILS_ENV=production rails db:setup")
        puts "ERROR: Failed to generate production data file."
        exit(1)
      end
      File.chmod(0444, data_file) if File.exist?(data_file)
      puts "Production data file generated at #{data_file}."
    else
      puts "#{data_file} is up to date. No action taken."
    end
  end
end 