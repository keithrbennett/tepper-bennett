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

  def canonical_url
    # Ensure the host is correctly set to 'www.tepper-bennett.com' and the path is appended without extra slashes
    url = root_url(protocol: 'https', host: 'www.tepper-bennett.com') + request.path
    url.chomp!('/') if url.end_with?('//') # Remove double trailing slashes if present
    url
  end
end
