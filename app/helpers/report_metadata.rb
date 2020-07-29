class ReportMetadata < Struct.new(:rpt_type, :title, :report)

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
        title:           title,
        content_tab_id:  "content-tab-#{rpt_type}"
    }
  end
end
