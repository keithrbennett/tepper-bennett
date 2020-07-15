module ReportsHelper

  class ReportMetadata < Struct.new(:rpt_type, :title, :fn_report)

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
          title:    title,
          copy_button_id:  "btn-copy-#{rpt_type}",
          content_tab_id:  "content-tab-#{rpt_type}"
      }
    end
  end
end
