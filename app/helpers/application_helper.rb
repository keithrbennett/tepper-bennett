module ApplicationHelper

  def external_link(text, url)
    render partial: 'application/external_link', locals: { text: text, url: url}
  end


  def li_external_link(text, url)
    render partial: 'application/li_external_link', locals: { text: text, url: url}
  end


  def inspect(object)
    object.ai(html: true, plain:true, multiline: true)
  end


  def youtube_text_song_link(text, youtube_code)
    render partial: 'application/youtube_text_song_link', locals: { text: text, youtube_code: youtube_code }
  end
end
