require_relative '../../config/environment'

namespace :reports do

  # Would this be shared by other files? (Bad if so.)
  DEFINED_TASKS = []

  def gen_task(task_type)
    desc "Generates a list of #{task_type}"
    task task_type do
      klass = Kernel.const_get("Report" + task_type.to_s.capitalize[0..-2] + 'CodesNames')
      puts klass.new.report_string
    end

    DEFINED_TASKS << task_type
  end


  %i(genres writers movies performers organizations songs).each { |task_type| gen_task(task_type) }

  task all: DEFINED_TASKS
end