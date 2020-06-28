class HomeController < ApplicationController

  def index
    raise 'method not here' unless methods.include?(:nav_tab)
    raise 'foo'

    respond_to { |format| format.html }
    render :index, layout: "application"
  end
end