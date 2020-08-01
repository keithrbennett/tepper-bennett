module ApplicationHelper

  def external_link(text, url)
    render partial: 'application/external_link', locals: { text: text, url: url}
  end


  def li_external_link(text, url)
    render partial: 'application/li_external_link', locals: { text: text, url: url}
  end


  def validate_artist_or_movie(artist_or_movie)
    unless %i(artist movie).include?(artist_or_movie)
      raise "Invalid symbol: #{artist_or_movie}. Must be :artist or :movie."
    end
  end


  def inspect(object)
    object.ai(html: true, plain:true, multiline: true)
  end


  def youtube_text_song_link(text, youtube_code)
    render partial: 'application/youtube_text_song_link', locals: { text: text, youtube_code: youtube_code }
  end
end
