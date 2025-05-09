class SongPlay < ApplicationRecord

  belongs_to :song
  has_and_belongs_to_many :performers

  validates_length_of :code, maximum: 25

  validates :code, presence: true
  validates :code, uniqueness: true

  validates :song, presence: true

  YOUTUBE_KEY_LENGTH = 11
  YOUTUBE_WATCH_URL_LENGTH = 43
  YOUTUBE_EMBED_URL_LENGTH = 41

  scope :best,  -> { where("code in (#{best_codes.map { |c| "'#{c}'"}.join(', ')})") }
  scope :elvis, -> do where(
    "id in (
       select song_play_id from performers_song_plays where performer_id = (
          select id from performers where code = 'elvis'
        )
     )")
  end

  def self.max_code_length = 25

  def self.youtube_watch_url(youtube_key) = "https://www.youtube.com/watch?v=#{youtube_key}"

  def youtube_watch_url = self.class.youtube_watch_url(youtube_key)

  # We are not using the embed_url methods at runtime,
  # but they are used by a rake task.
  def self.youtube_embed_url(youtube_key) = "https://www.youtube.com/embed/#{youtube_key}"

  def youtube_embed_url = self.class.youtube_embed_url(youtube_key)

  def self.best_codes
    @best_codes ||= %w{
        red-roses.andy-wms
        red-roses.bert-kmft
        red-roses.dean-martin
        red-roses.sinatra
        red-roses.guy-lomb
        young-ones.clf-rich
        kiss-fire.louis-arm
        kiss-fire.geo-gibbs
        nty-lady.ames-bros
        n-for-xmas.b-gordon
        suzy-snow.r-clooney
        ww-young.andy-wms
        bagel-lox.rob-schneid
        run-back-me.n-wilson
        crush-ny.c-francis
        ssss-heart.ink-spots
        smr-sounds.r-goulet
        tr-light.h-hermits
        when-arms.c-francis
        jenny-kiss.ed-albert
        shop-arnd.elvis
        angel.elvis
        am-i-ready.elvis
        lady-loves.elvis
        puppet.elvis
        tear-rain.a-prysock
        kewpie-doll.p-como
        d-in-love.clf-rich
        santa-daddy.b-gordon
        long-way.sinatra
        t-t-fingers.stargazers
    }
  end
end
