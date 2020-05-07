class StaticPagesController < ActionController::Base

  Recording = Struct.new(:title, :artist, :url)

  def initialize
    init_recordings
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


  def blog
    redirect_to('http://blog.bbs-software.com')
  end


  def techhumans
    redirect_to('http://techhumans.com')
  end


  def init_recordings
    @recordings = [
        Recording.new(
            'Red Roses for a Blue Lady',
            'Andy Williams',
            'https://www.youtube.com/watch?v=HssRO5b_ED0'
        ),
        Recording.new(
            'Red Roses for a Blue Lady',
            'Bert Kaempfert and His Orchestra',
            'https://www.youtube.com/watch?v=zt6WdnrAvpE'
        ),
        Recording.new(
            'Red Roses for a Blue Lady',
            'Dean Martin',
            'https://www.youtube.com/watch?v=drU6kuih41w'
        ),
        Recording.new(
            'Red Roses for a Blue Lady',
            'Frank Sinatra',
            'https://www.youtube.com/watch?v=yeMFw9tBrGo'
        ),
        Recording.new(
            'Red Roses for a Blue Lady',
            'Guy Lombardo And His Royal Canadians',
            'https://www.youtube.com/watch?v=_41H2cpTzNc'
        ),
        Recording.new(
            'The Young Ones',
            'Cliff Richard',
            'https://www.youtube.com/watch?v=BxNohANhJiA'
        ),
        Recording.new(
            'The Naughty Lady of Shady Lane',
            'The Ames Brothers',
            'https://youtu.be/9HxB7lxbTnI'
        ),
        Recording.new(
            'Kiss of Fire',
            'Louis Armstrong',
            'https://youtu.be/gVxwN3Eaf_U'
        ),
        Recording.new(
            "Nuttin' for Christmas",
            'Barry Gordon',
            'https://youtu.be/aUA7BPnog_0'
        ),
        Recording.new(
            'Suzy Snowflake',
            'Rosemary Clooney',
            'https://www.youtube.com/watch?v=UiFXZhU5kp4'
        ),
        Recording.new(
            'Wonderful World of the Young',
            'Andy Williams',
            'https://www.youtube.com/watch?v=eoRVnPH8uUI'
        ),
        Recording.new(
            'Bagel & Lox',
            'Rob Schneider',
            'https://www.youtube.com/watch?v=dv4h8yU_N7o'
        ),
        Recording.new(
            "Don't Come Running Back to Me",
            'Nancy Wilson',
            'https://youtu.be/QlzCpTEhhQM'
        ),
        Recording.new(
            "I've Got a Crush on New York Town",
            'Connie Francis',
            'https://www.youtube.com/watch?v=0_Gycn0UJ9M'
        ),
        Recording.new(
            'Say Something Sweet to Your Sweetheart',
            'The Ink Spots',
            'https://www.youtube.com/watch?v=z617AUVXyMs'
        ),
        Recording.new(
            'Summer Sounds',
            'Robert Goulet',
            'https://www.youtube.com/watch?v=1gGJ8AHYloQ'
        ),
        Recording.new(
            'Travelling Light',
            "Herman's Hermits",
            'https://www.youtube.com/watch?v=stDqoS3zeTE'
        ),
        Recording.new(
            'When the Boy in Your Arms',
            'Connie Francis',
            'https://youtu.be/FudzowDyQn0'
        ),
        Recording.new(
            'Jenny Kissed Me',
            'Eddie Albert',
            'https://youtu.be/Vf-9-rNHjcE'
        ),
        Recording.new(
            'Shoppin Around',
            'Elvis Presley',
            'https://youtu.be/ADjm8yzYFW4'
        ),
        Recording.new(
            'Kewpie Doll',
            'Perry Como',
            'https://www.youtube.com/watch?v=YJ9W47TIRR4&feature=youtu.be'
        ),
        Recording.new(
            'Santa Claus Looks Just Like Daddy',
            'Art Mooney & His Orchestra with Barry Gordon',
            'https://www.youtube.com/watch?v=0JCXmuNnrNc'
        ),
    ]
  end
end

