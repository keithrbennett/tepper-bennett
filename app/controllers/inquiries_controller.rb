class InquiriesController < ApplicationController

  def index
    respond_to { |format| format.html }
    @title_suffix = 'Inquiries'
    render :index, layout: "application"
  end
end
