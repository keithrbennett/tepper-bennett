class HomeController < ApplicationController

  def index
    $stderr.puts("Using Rails v#{Rails.version}, Ruby v#{RUBY_VERSION}")
    respond_to { |format| format.html }
    render :index, layout: "application"
  end
end