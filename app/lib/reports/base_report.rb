class BaseReport

  attr_reader :field_names

  VALID_FORMATS = %w(html text json yaml ap)

  def content(rpt_format)
    unless VALID_FORMATS.include?(rpt_format)
      raise "Invalid format (#{rpt_format.inspect}); must be one of #{VALID_FORMATS.join(', ')}"
    end
    case rpt_format
    when 'html'
      to_html
    when 'text'
      to_text
    when 'json'
      to_json
    when 'yaml'
      to_yaml
    when 'ap'
      to_awesome_print
    end
  end

  def preize_text(text)
    "<div><pre>\n#{text}</pre></div>\n".html_safe
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


  # @param column_headings array of column heading strings'
  # @param table_data a multiline string of <tr> elements
  # @return a string containing the HTML for the table, including surrounding div's.
  def html_report_table(column_headings, table_data)
    html = <<HEREDOC
    <div class="table-responsive">
    <table class="table #{'data-table' if table_data.count("\n") >= 12} thead-dark table-striped">
    <thead class="thead-dark">
      <tr>#{column_headings.map { |h| "<th>#{h}</th>"}.join}</tr>
    </thead>
    #{table_data}
    </table>
    </div>
HEREDOC
    html.html_safe
  end

  # @param an array of field strings
  # @return the multiline string of <tr> and <td> elements.
  def records_to_html_table_data(records)
    html = StringIO.new
    html << "\n"
    records.each do |record|
      html << "<tr>"
      record.each do |field_value|
        html << "<td>" << field_value << "</td>"
      end
      html << "</tr>\n"
    end
    html.string.html_safe
  end


  def pluck_to_hash(enumerable, *field_names)
    enumerable.pluck(*field_names).map do |field_values|
      field_names.zip(field_values).each_with_object({}) do |(key, value), result_hash|
        result_hash[key] = value
      end
    end
  end
end
