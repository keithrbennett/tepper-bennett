class StaticPagesController < ActionController::Base

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
end
