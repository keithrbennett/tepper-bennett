class ResourcesController < ApplicationController

  def index
    respond_to { |format| format.html }
    render :index, layout: "application"
  end
end