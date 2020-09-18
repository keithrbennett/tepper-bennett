class ElvisController < ApplicationController


  Recording = Struct.new(:title, :artist, :yt_video_code, :movie, :embed_url, :watch_url)
  class Recording
    def embed_url; "https://www.youtube.com/embed/#{yt_video_code}";   end
    def watch_url; "https://www.youtube.com/watch?v=#{yt_video_code}"; end
  end


  def index
    respond_to { |format| format.html }
    @title_suffix = 'Elvis'
    render :index, layout: "application"
  end
end

