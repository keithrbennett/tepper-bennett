class SongsController < ApplicationController

  Recording = Struct.new(:title, :artist, :yt_video_code, :movie, :embed_url, :watch_url)
  class Recording
    def embed_url; "https://www.youtube.com/embed/#{yt_video_code}";   end
    def watch_url; "https://www.youtube.com/watch?v=#{yt_video_code}"; end
  end


  def scope_string_to_scope(scope_string)
    {
        'best'  => SongPlay.best,
        'elvis' => SongPlay.elvis,
        'all'   => SongPlay.all
    }.fetch(scope_string)
  end


  def index
    respond_to { |format| format.html }
    songs_scope = scope_string_to_scope(params[:songs_scope] || 'best')
    render :index, layout: "application", locals: { songs_scope: songs_scope }
  end


  def show
    render :song, layout: 'application', locals: { song: Song.find_by_code(params[:code]) }
  end
end