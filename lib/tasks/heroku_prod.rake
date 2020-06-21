require_relative '../../config/environment'

namespace :heroku_prod do

  def gen_update_db_task
    desc 'Update the data base using seeds.rb'
    task 'update_db' do
      puts "Running heroku pg:reset..."
      puts `heroku pg:reset --confirm tepper-bennett 2>&1`
      raise "heroku pg:reset returned #{$?.exitstatus}" unless $?.exitstatus == 0
      puts "Running rails db:migrate..."
      puts `heroku run rails db:migrate 2>&1`
      puts "Running db:seed..."
      puts `heroku run rails db:seed 2>&1`
    end
  end

  gen_update_db_task
end

