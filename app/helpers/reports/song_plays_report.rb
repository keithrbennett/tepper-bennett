class SongPlaysReport < BaseReport

  attr_reader :records, :youtube_link_renderer

  def initialize
    @report_type = 'song_plays'
  end

  def populate
    @records = SongPlay.joins(:song).all.order('songs.name, id').map do |song_play|
      song = song_play.song
      perfs = song_play.performers.order(:name)
      {
          song_code: song.code,
          song_name: song.name,
          performers: pluck_to_hash(perfs, :code, :name),
          youtube_key: song_play.youtube_key
      }
    end
  end

  def to_html
    headings = ['Song Code', 'Song Name', 'Perf Code', 'Performer Name', 'YouTube Key', 'Play']
    data = records.map do |r|
      performers = r[:performers]
      youtube_key = r[:youtube_key]
      url = SongPlay.youtube_embed_url(youtube_key)
      youtube_link = render_to_string( partial: 'application/youtube_image_link', locals: { url: url })

      [
          r[:song_code],
          r[:song_name],
          performers.pluck(:code).join("<br/>"),
          performers.pluck(:name).join("<br/>"),
          youtube_key,
          youtube_link
      ]
    end
    html_report_table(headings, data)
  end

  def to_raw_text
    SongPlaysTextReport.new(records).report_string
  end

end
