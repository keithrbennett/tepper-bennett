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

    r = ->(title, artist, code) { Recording.new(title, artist, code) }

    @recordings = [
        r.('Red Roses for a Blue Lady',                   'Andy Williams',                        'HssRO5b_ED0'),
        r.('Red Roses for a Blue Lady',                   'Bert Kaempfert and His Orchestra',     'zt6WdnrAvpE'),
        r.('Red Roses for a Blue Lady',                   'Dean Martin',                          'drU6kuih41w'),
        r.('Red Roses for a Blue Lady',                   'Frank Sinatra',                        'yeMFw9tBrGo'),
        r.('Red Roses for a Blue Lady',                   'Guy Lombardo And His Royal Canadians', '_41H2cpTzNc'),
        r.('The Young Ones',                              'Cliff Richard',                        'BxNohANhJiA'),
        r.('Kiss of Fire',                                'Louis Armstrong',                      'gVxwN3Eaf_U'),
        r.('Kiss of Fire',                                'Georgia Gibbs',                        'mLpzfER6w3c'),
        r.('The Naughty Lady of Shady Lane',              'The Ames Brothers',                    '9HxB7lxbTnI'),
        r.("Nuttin' for Christmas",                       'Barry Gordon',                         '9J-hyQGmhlo'),
        r.('Suzy Snowflake',                              'Rosemary Clooney',                     'UiFXZhU5kp4'),
        r.('Wonderful World of the Young',                'Andy Williams',                        'eoRVnPH8uUI'),
        r.('Bagel & Lox',                                 'Rob Schneider',                        'dv4h8yU_N7o'),
        r.("Don't Come Running Back to Me",               'Nancy Wilson',                         'QlzCpTEhhQM'),
        r.("I've Got a Crush on New York Town",           'Connie Francis',                       '0_Gycn0UJ9M'),
        r.('Say Something Sweet to Your Sweetheart',      'The Ink Spots',                        'z617AUVXyMs'),
        r.('Summer Sounds',                               'Robert Goulet',                        '1gGJ8AHYloQ'),
        r.('Travelling Light',                            "Herman's Hermits",                     'stDqoS3zeTE'),
        r.('When the Boy in Your Arms',                   'Connie Francis',                       'FudzowDyQn0'),
        r.('Jenny Kissed Me',                             'Eddie Albert',                         '/Vf-9-rNHjcE'),
        r.('Shoppin Around',                              'Elvis Presley',                        'ADjm8yzYFW4'),
        r.('Angel',                                       'Elvis Presley',                        '7RQuoPVMPT0'),
        r.('Am I Ready',                                  'Elvis Presley',                        'E2J13o-RsxA'),
        r.('The Lady Loves Me',                           'Elvis Presley and Ann-Margret',        'Fv0bpfGfzls'),
        r.('Puppet on a String',                          'Elvis Presley',                        'RjWoFTu0W28'),
        r.('Teardrops in the Rain',                       'Arthur Prysock',                       '7xVk2GY-TOI'),
        r.('Kewpie Doll',                                 'Perry Como',                           'YJ9W47TIRR4'),
        r.('Santa Claus Looks Just Like Daddy',           'Art Mooney & His Orchestra with Barry Gordon', '0JCXmuNnrNc'),
        r.("It's a Long Way from Your House to My House", 'Frank Sinatra',                        '7-tcw6w4Cj4'),
        r.('Twenty Tiny Fingers',                         'The Stargazers',                       'K0ozZZ_RhP8'),
    ]
  end

  def init_elvis_pane_recordings
    r = ->(title, code, movie) { Recording.new(title, 'Elvis Presley', code, movie) }

    @elvis_recordings = [
        r.('G. I. Blues',                       'GkyjCJvHLsA', 'G. I. Blues'),
        r.('Stay Away',                         'wr6MQtFLX6k', 'Stay Away, Joe'),
        r.('New Orleans',                       'A9C-oQ_mFSc', 'King Creole'),
        r.('Kismet',                            'fnqC2I9QpIU', 'Harum Scarum'),
        r.('Island of Love',                    '6RilIva9usA', 'Blue Hawaii'),
        r.('Angel',                             '7RQuoPVMPT0', 'Follow That Dream'),
        r.('Am I Ready',                        'E2J13o-RsxA', 'Spinout'),
        r.('The Lady Loves Me',                 'Fv0bpfGfzls', 'Viva Las Vegas'),
        r.('Puppet on a String',                'RjWoFTu0W28', 'Girl Happy'),
        r.('The Bullfighter Was a Lady',        'kHTX0kU3sEo', 'Fun in Acapulco'),
        r.('Shoppin Around',                    'ADjm8yzYFW4', 'G. I. Blues'),
        r.("It's a Wonderful World",            '5GwapUKv5V4', 'Roustabout'),
        r.('Western Union',                     '-cs_R-QWqcA', 'Speedway'),
        r.("Petunia, the Gardener's Daughter",  'wuzbUsy6snc', 'Frankie and Johnny'),
        r.('All That I Am',                     'IIpNWh_0Tw8', 'Spinout'),
    ]
  end
end

