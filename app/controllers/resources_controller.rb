class ResourcesController < ApplicationController

  def index
    respond_to { |format| format.html }
    @title_suffix = 'Resources'
    render :index, layout: "application"
  end
end