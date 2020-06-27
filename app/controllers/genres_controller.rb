class GenresController < ApplicationController

  def index
    respond_to { |format| format.html }
    # render :index, layout: "application"
    render :index
  end
end
