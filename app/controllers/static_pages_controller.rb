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
            'Bert Kaempfert and His Orchestra',
            'https://www.youtube.com/watch?v=zt6WdnrAvpE'
        ),
        Recording.new(
            'The Young Ones',
            'Cliff Richard',
            'https://www.youtube.com/watch?v=BxNohANhJiA'
        ),
        Recording.new(
            "I've Got a Crush on New York Town",
            'Connie Francis',
            'https://www.youtube.com/watch?v=0_Gycn0UJ9M'
        ),
    ]
  end
end
