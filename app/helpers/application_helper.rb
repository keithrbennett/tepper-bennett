module ApplicationHelper

  def external_link(text, url)
    tag.a(text, href:url, target: '_blank').html_safe
  end


  def li_external_link(text, url)
    tag.li(external_link(text.html_safe, url)).html_safe
  end


  def youtube_image_link(url)
    %Q{
    <a class="image-cell youtube-view" data-toggle="modal" data-target="#youTubeViewerModal" data-url="#{url}">
          #{image_tag('youtube.png', alt: 'Listen')}
    </a>
    }.html_safe
  end


  def validate_artist_or_movie(artist_or_movie)
    unless %i(artist movie).include?(artist_or_movie)
      raise "Invalid symbol: #{artist_or_movie}. Must be :artist or :movie."
    end
  end


  # Outputs the <tr> for a table row, with either the artist or the movie occupying the 2nd column,
  # depending on the 2nd argument, :artist or :movie.
  def song_table_row(recording, artist_or_movie)
    validate_artist_or_movie(artist_or_movie)
    artist_or_title_value = (artist_or_movie == :artist) ? recording.artist : recording.movie
    url = recording.embed_url

    html = <<HEREDOC
    <tr>
      <td>#{recording.title}</td>
      <td>#{artist_or_title_value}</td>
      <td align="center">
        <a class="image-cell youtube-view" data-toggle="modal" data-target="#youTubeViewerModal"
          data-url="#{url}"
        />
          #{image_tag('youtube.png', alt: 'Listen')}
        </a>
      </td>
    </tr>
HEREDOC
    html.html_safe
  end


def song_table(artist_or_movie)
  validate_artist_or_movie(artist_or_movie)
  heading = artist_or_movie.capitalize
  recordings = artist_or_movie == :artist ? @recordings : @elvis_recordings
  recordings_html = recordings.map { |r| song_table_row(r, artist_or_movie) }.join("\n")

  html = <<HEREDOC
    <div class="table-responsive">
      <table class="table thead-dark table-striped">
        <thead class="thead-dark">
        <tr>
          <th>Title</th>
          <th>#{heading}</th>
          <th style="text-align: center;">Listen</th>
        </tr>
        </thead>
    
        #{recordings_html}
      </table>
    </div>

HEREDOC

  html.html_safe
end


def nav_tab(internal_name, display_name, active: false, additional_class: '')
  active_text = active ? ' active' : ''
  aria        = active ? 'true'    : 'false'

  html = <<HEREDOC
    <a class="nav-item nav-link#{active_text} #{additional_class}" id="nav-#{internal_name}-tab" data-toggle="tab" href="#nav-#{internal_name}" role="tab" aria-selected="#{aria}">#{display_name}</a>
HEREDOC
  html.html_safe
end


def report_formats_nav_tab(panel_internal_name, panel_display_name, active: false)
  nav_tab(panel_internal_name, panel_display_name, active: active, additional_class: 'rpt-fmt-item')
end


def main_nav_tab(panel_internal_name, panel_display_name, active: false)
  nav_tab(panel_internal_name, panel_display_name, active: active)
end


# If html_text is specified, render that, else render the partial whose name is `name`.
def nav_content(name:, html_text: nil, active: false)
  div_class = 'tab-pane'
  div_class += ' show active' if active

  tag.div(class: div_class, id: "nav-#{name}", role: 'tabpanel', 'aria-labelledby'.to_sym => "nav-#{name}-tab") do
    if html_text
      html_text
    else
      render(name)
    end
  end
end

def youtube_text_song_link(text, youtube_code)
  html = tag.a(
      href: '#',
      class: "youtube-view",
      'data-url'.to_sym => SongPlay.youtube_embed_url(youtube_code),
      'data-toggle'.to_sym => 'modal',
      'data-target'.to_sym => '#youTubeViewerModal') do
    # onclick: %Q{setPlayerYoutubeUrl('#{youtube_embed_url(youtube_code)}');}) do
    text
  end

  html.html_safe
end
end
