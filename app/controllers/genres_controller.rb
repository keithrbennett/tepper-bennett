class GenresController < ApplicationController

  def index
    respond_to { |format| format.html }
    @title_suffix = 'Genres'
    render :index, layout: "application"
  end
end
