namespace :db do
  def self.generate_data_file!
    require 'yaml'
    require 'fileutils'
    
    puts "Generating SQLite data file..."
    
    # Ensure the db directory exists
    FileUtils.mkdir_p('db')
    
    # Remove existing data file if it exists
    FileUtils.rm_f('db/data.sqlite3')
    
    # Create a new SQLite database
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/data.sqlite3'
    )
    
    # Run migrations
    puts "Running migrations..."
    Rake::Task['db:migrate'].invoke
    
    # Load seed data from YAML files
    puts "Loading seed data..."
    Rake::Task['db:seed'].invoke
    
    # Make the file read-only
    FileUtils.chmod(0444, 'db/data.sqlite3')
    
    puts "SQLite data file generated successfully at db/data.sqlite3"
    puts "Don't forget to commit the file to your repository!"
  end

  def self.data_file_stale?(data_file, source_files)
    return true unless File.exist?(data_file)
    data_mtime = File.mtime(data_file)
    latest_source_mtime = source_files.map { |f| File.exist?(f) ? File.mtime(f) : Time.at(0) }.max
    latest_source_mtime > data_mtime
  end

  desc "Generate SQLite data file from YAML files"
  task generate_data_file: :environment do
    generate_data_file!
  end

  desc "Generate SQLite data file only if YAML, migration, or seeds.rb files are newer"
  task generate_data_file_if_stale: :environment do
    data_file = 'db/data.sqlite3'
    yaml_files = Dir['db/*.yml']
    migration_files = Dir['db/migrate/*.rb']
    seeds_file = 'db/seeds.rb'
    files = yaml_files + migration_files + [seeds_file]

    if data_file_stale?(data_file, files)
      puts "Generating data file because it is missing or stale..."
      generate_data_file!
    else
      puts "#{data_file} is up to date. No action taken."
    end
  end
end 