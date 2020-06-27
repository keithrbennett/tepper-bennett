class ElvisController < ApplicationController


  Recording = Struct.new(:title, :artist, :yt_video_code, :movie, :embed_url, :watch_url)
  class Recording
    def embed_url; "https://www.youtube.com/embed/#{yt_video_code}";   end
    def watch_url; "https://www.youtube.com/watch?v=#{yt_video_code}"; end
  end


  def init_recordings
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


  def index
    init_recordings
    respond_to { |format| format.html }
    # render :index, layout: "application"
    render :index
  end
end

