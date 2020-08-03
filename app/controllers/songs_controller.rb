class SongsController < ApplicationController

  Recording = Struct.new(:title, :artist, :yt_video_code, :movie, :embed_url, :watch_url)
  class Recording
    def embed_url; "https://www.youtube.com/embed/#{yt_video_code}";   end
    def watch_url; "https://www.youtube.com/watch?v=#{yt_video_code}"; end
  end



  def index
    respond_to { |format| format.html }
    render :index, layout: "application"
  end

  def show
    render :song, layout: 'application', locals: { song: Song.find_by_code(params[:code]) }
  end
end