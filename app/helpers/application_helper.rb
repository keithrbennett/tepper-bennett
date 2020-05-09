module ApplicationHelper

  def external_link(text, url)
    tag.a(text.html_safe, href:url, target: '_blank').html_safe
  end

  def external_image_link(image_filename, url)
    tag.a(href: url, target: '_blank') do
      image_tag(image_filename, alt: 'YouTube')
    end
  end

  def youtube_image_link(url)
    external_image_link('youtube.png', url)
  end

  def li_external_link(text, url)
    tag.li(external_link(text.html_safe, url)).html_safe
  end

  def youtube_icon_image
    image_path('youtube.png')
  end


  # Outputs the <tr> for a table row, with either the artist or the movie occupying the 2nd column,
  # depending on the 2nd argument, :artist or :movie.
  def song_table_row(recording, artist_or_movie)
    unless %i(artist movie).include?(artist_or_movie)
      raise "Invalid symbol: #{artist_or_movie}"
    end

    artist_or_title_value = (artist_or_movie == :artist) ? recording.artist : recording.movie

    html = <<HEREDOC
    <tr>
      <td>#{recording.title}</td>
      <td>#{artist_or_title_value}</td>
      <td>
        <input type="image" data-toggle="modal" data-target="#exampleModal"
               onclick="setPlayerYoutubeUrl('#{recording.embed_url}');"
              src="#{youtube_icon_image}" />
      </td>
    </tr>
HEREDOC
    html.html_safe
  end
end
