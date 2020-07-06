module ReportsHelper

  class ReportMetadata < Struct.new(:rpt_type, :title, :fn_report) #, :report_text, :report_json, :report_yaml)

    include ApplicationHelper

    def button_id
      rpt_type + '_button'
    end

    def content_id
      rpt_type + '_content'
    end

    def locals
      {
          rpt_type:        rpt_type,
          card_button_id:  button_id,
          card_content_id: content_id,
          report_title:    title,
          # fn_url:          ->(format) { "/reports?type=#{content_id}&format=#{format}" },
          # reporters:       {
          #     html: fn_html_report,
          #     text: -> { report_text },
          #     json: -> { report_json },
          #     yaml: -> { report_yaml },
          # },
          copy_button_id:  "btn-copy-#{rpt_type}",
          content_tab_id:  "content-tab-#{rpt_type}"
      }
    end

    # def report_filespec(extension)
    #   File.join(Rails.root, 'app', 'generated_reports', "#{rpt_type}_report#{extension}")
    # end
    #

    # def preize_file_content(extension)
    #   "<div><pre>\n".html_safe + File.read(report_filespec(extension)) + "</pre></div>\n".html_safe
    # end

    # def report_text
    #   @report_text ||= preize_file_content('.txt')
    # end
    #
    # def report_json
    #   @report_json ||= preize_file_content('.json')
    # end
    #
    # def report_yaml
    #   @report_yaml ||= preize_file_content('.yaml')
    # end
  end
end
