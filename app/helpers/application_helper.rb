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
    base_uri = URI(root_url(protocol: 'https', host: 'www.tepper-bennett.com'))
    path_uri = URI(request.path)
    url = (base_uri + path_uri.path).to_s
    url.chomp!('/') if url.end_with?('//') # Remove double trailing slashes if present
    url
  end
end
