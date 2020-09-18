class HomeController < ApplicationController

  def index
    respond_to { |format| format.html }
    @title_suffix = 'Home'
    render :index, layout: "application"
  end
end