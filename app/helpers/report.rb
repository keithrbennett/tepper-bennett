# Contains report metadata and data.
class Report < Struct.new(:key, :title, :html_report) #, :report_text, :report_json, :report_yaml)

  def button_id
    key + '_button'
  end

  def content_id
    key + '_content'
  end

  def locals
    {
        name:            key,
        card_button_id:  button_id,
        card_content_id: content_id,
        report_title:    title,
        report_html:     html_report,
        report_text:     report_text,
        report_json:     report_json,
        report_yaml:     report_yaml,
        copy_button_id:  "btn-copy-#{key}",
        content_tab_id:  "content-tab-#{key}"
    }
  end

  def report_filespec(extension)
    File.join(Rails.root, 'app', 'generated_reports', "#{key}_report#{extension}")
  end


  def preize_file_content(extension)
    "<div><pre>\n".html_safe + File.read(report_filespec(extension)) + "</pre></div>\n".html_safe
  end

  def report_text
    @report_text ||= preize_file_content('.txt')
  end

  def report_json
    @report_json ||= preize_file_content('.json')
  end

  def report_yaml
    @report_yaml ||= preize_file_content('.yaml')
  end
end
