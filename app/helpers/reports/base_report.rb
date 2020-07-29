class BaseReport

  attr_reader :field_names

  # TODO: replace this with alias_method?
  def render(*args)
    @renderer ||= ApplicationController.renderer
    @renderer.render(*args)
  end

  def render_to_string(*args)
    @renderer_to_string ||= ActionController::Base.new
    @renderer_to_string.render_to_string(*args)
  end

  def report_type
    raise "This method must be implemented in a subclass."
  end


  # Populates @data with data from the DB
  def populate
    raise "This method must be implemented in a subclass."
  end


  def preize_text(text)
    "<div><pre>\n#{text}</pre></div>\n".html_safe
  end


  def to_html
    raise "This method must be implemented in a subclass."
  end


  def to_json
    preize_text(JSON.pretty_generate(records))
  end


  def to_yaml
    preize_text(records.to_yaml)
  end


  def to_awesome_print
    preize_text(records.ai(html: true, plain: true, multiline: true))
  end


  def to_text
    preize_text(to_raw_text)
  end


  def content_provider(format)
  end


  def content(rpt_format)
    @content_provider_hash ||= {
        'html' => -> { to_html },
        'text' => -> { to_text },
        'json' => -> { to_json },
        'yaml' => -> { to_yaml },
        'ap'   => -> { to_awesome_print },
    }
    content_provider = @content_provider_hash[rpt_format]
    unless content_provider
      raise "Bad format type: #{format.inspect}. Must be one of #{FORMAT_CONTENT.keys.join(', ')}."
    end
    content_provider.()
  end


  # @param column_headings array of column heading strings'
  # @param table_data a multiline string of <tr> elements
  # @return a string containing the HTML for the table, including surrounding div's.
  def html_report_table(column_headings, records)
    render partial: 'reports/report_table', locals: { column_headings: column_headings, records: records }
  end


  def pluck_to_hash(enumerable, *field_names)
    enumerable.pluck(*field_names).map do |field_values|
      field_names.zip(field_values).each_with_object({}) do |(key, value), result_hash|
        result_hash[key] = value
      end
    end
  end
end
