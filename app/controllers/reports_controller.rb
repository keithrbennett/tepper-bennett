class ReportsController < ApplicationController

  class ReportMetadata < Struct.new(:key, :title)

    def button_id
      key + '_button'
    end

    def content_id
      key + '_content'
    end

    def locals
      {
          card_button_id: button_id,
          card_content_id: content_id,
          report_title: title,
          report_text: report_text
      }
    end

    def report_filespec
      File.join(Rails.root, 'outputs', "#{key}_report.txt")
    end

    def report_text
      unless @report_text
        lines = File.readlines(report_filespec).map { |line| '<p>'.html_safe + line + '</p>'.html_safe}
        @report_text = "<div><pre>\n".html_safe + File.read(report_filespec) + "\n</pre></div>\n".html_safe
      end
      @report_text
    end
  end
  # ---- end ReportMetadata class


def initialize
    @report_metadata ||= [
        ['songs_codes_names', 'Songs'],
        ['performers_codes_names', 'Performers'],
        ['genres_codes_names', 'Genres'],
        ['song_performers',  'Song Performers'],
        ['song_genres', 'Genres by Song'],
        ['genre_songs', 'Songs by Genre'],
        ['movies', 'Movies'],
        ['movie_songs', 'Movies Songs'],
        ['organizations_codes_names', 'Organizations'],
        ['song_rights_admins', 'Song Rights Administrators'],
        ['writers_codes_names', 'Writers'],
    ].map { |(key, title)| ReportMetadata.new(key, title) }
  end



  def respond
    respond_to do |format|
      format.html
    end
  end


  def show
    respond
    render :reports, layout: "application"
  end

end
