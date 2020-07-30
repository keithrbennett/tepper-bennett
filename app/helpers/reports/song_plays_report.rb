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
    render partial: 'reports/song_plays_table', locals: { column_headings: headings, records: records }
  end

  def to_raw_text
    SongPlaysTextReport.new(records).report_string
  end

end
