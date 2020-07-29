class SongPlaysReport < BaseReport

  attr_reader :records, :youtube_link_renderer

  def initialize(youtube_link_renderer)
    @youtube_link_renderer = youtube_link_renderer
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
      youtube_link = youtube_link_renderer.(url)
      [
          r[:song_code],
          r[:song_name],
          performers.pluck(:code).join("<br/>"),
          performers.pluck(:name).join("<br/>"),
          youtube_key,
          youtube_link]
    end
    table_data = records_to_html_table_data(data)
    html_report_table(headings, table_data)
  end

  def to_raw_text
    SongPlaysTextReport.new(records).report_string
  end

end
