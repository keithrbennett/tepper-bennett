namespace :db do
  desc "Generate SQLite data file from YAML files"
  task generate_data_file: :environment do
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
end 