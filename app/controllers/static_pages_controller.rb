class StaticPagesController < ActionController::Base

  Recording = Struct.new(:title, :artist, :yt_video_code, :movie, :embed_url, :watch_url)
  class Recording
    def embed_url; "https://www.youtube.com/embed/#{yt_video_code}";   end
    def watch_url; "https://www.youtube.com/watch?v=#{yt_video_code}"; end
  end

  def initialize
    init_songs_pane_recordings
    init_elvis_pane_recordings
  end

  def respond
    respond_to do |format|
      format.html
    end
  end


  def index
    respond
    render layout: "application"
  end


  def about; end


  def init_songs_pane_recordings
    @recordings = [
        Recording.new(
            'Red Roses for a Blue Lady',
            'Andy Williams',
            'HssRO5b_ED0'
        ),
        Recording.new(
            'Red Roses for a Blue Lady',
            'Bert Kaempfert and His Orchestra',
            'zt6WdnrAvpE'
        ),
        Recording.new(
            'Red Roses for a Blue Lady',
            'Dean Martin',
            'drU6kuih41w'
        ),
        Recording.new(
            'Red Roses for a Blue Lady',
            'Frank Sinatra',
            'yeMFw9tBrGo'
        ),
        Recording.new(
            'Red Roses for a Blue Lady',
            'Guy Lombardo And His Royal Canadians',
            '_41H2cpTzNc'
        ),
        Recording.new(
            'The Young Ones',
            'Cliff Richard',
            'BxNohANhJiA'
        ),
        Recording.new(
            'Kiss of Fire',
            'Louis Armstrong',
            'gVxwN3Eaf_U'
        ),
        Recording.new(
            'The Naughty Lady of Shady Lane',
            'The Ames Brothers',
            '9HxB7lxbTnI'
        ),
        Recording.new(
            "Nuttin' for Christmas",
            'Barry Gordon',
            'aUA7BPnog_0'
        ),
        Recording.new(
            'Suzy Snowflake',
            'Rosemary Clooney',
            'UiFXZhU5kp4'
        ),
        Recording.new(
            'Wonderful World of the Young',
            'Andy Williams',
            'eoRVnPH8uUI'
        ),
        Recording.new(
            'Bagel & Lox',
            'Rob Schneider',
            'dv4h8yU_N7o'
        ),
        Recording.new(
            "Don't Come Running Back to Me",
            'Nancy Wilson',
            'QlzCpTEhhQM'
        ),
        Recording.new(
            "I've Got a Crush on New York Town",
            'Connie Francis',
            '0_Gycn0UJ9M'
        ),
        Recording.new(
            'Say Something Sweet to Your Sweetheart',
            'The Ink Spots',
            'z617AUVXyMs'
        ),
        Recording.new(
            'Summer Sounds',
            'Robert Goulet',
            '1gGJ8AHYloQ'
        ),
        Recording.new(
            'Travelling Light',
            "Herman's Hermits",
            'stDqoS3zeTE'
        ),
        Recording.new(
            'When the Boy in Your Arms',
            'Connie Francis',
            'FudzowDyQn0'
        ),
        Recording.new(
            'Jenny Kissed Me',
            'Eddie Albert',
            '/Vf-9-rNHjcE'
        ),
        Recording.new(
            'Shoppin Around',
            'Elvis Presley',
            'ADjm8yzYFW4'
        ),
        Recording.new(
            'Angel',
            'Elvis Presley',
            '7RQuoPVMPT0'
        ),
        Recording.new(
            'Am I Ready',
            'Elvis Presley',
            'E2J13o-RsxA'
        ),
        Recording.new(
            'The Lady Loves Me',
            'Elvis Presley and Ann-Margret',
            'Fv0bpfGfzls'
        ),
        Recording.new(
            'Puppet on a String',
            'Elvis Presley',
            'RjWoFTu0W28'
        ),
        Recording.new(
            'Kewpie Doll',
            'Perry Como',
            'YJ9W47TIRR4'
        ),
        Recording.new(
            'Santa Claus Looks Just Like Daddy',
            'Art Mooney & His Orchestra with Barry Gordon',
            '0JCXmuNnrNc'
        ),
        Recording.new(
            "It's a Long Way from Your House to My House",
            'Frank Sinatra',
            '7-tcw6w4Cj4'
        ),
        Recording.new(
            'Twenty Tiny Fingers',
            'The Stargazers',
            'K0ozZZ_RhP8'
        ),
    ]
  end

  def init_elvis_pane_recordings
    @elvis_recordings = [
        Recording.new(
            'Shoppin Around',
            'Elvis Presley',
            'ADjm8yzYFW4',
            'G. I. Blues'
        ),
        Recording.new(
            'Angel',
            'Elvis Presley',
            '7RQuoPVMPT0',
            'Follow That Dream'
        ),
        Recording.new(
            'Am I Ready',
            'Elvis Presley',
            'E2J13o-RsxA',
            'Spinout'
        ),
        Recording.new(
            'The Lady Loves Me',
            'Elvis Presley and Ann-Margret',
            'Fv0bpfGfzls',
            'Viva Las Vegas'
        ),
        Recording.new(
            'Puppet on a String',
            'Elvis Presley',
            'RjWoFTu0W28',
            'Girl Happy'
        ),
    ]
  end
end

