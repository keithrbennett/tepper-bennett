class ReportsController < ApplicationController

  include ReportsHelper

  def index
    respond_to { |format| format.html }
    locals = {
        target_rpt_format: params[:rpt_format]&.downcase,
        target_rpt_type:   params[:type]
    }
    render :index, layout: "application", locals: locals
  end


  def records_to_cell_data(records)
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


  def html_report_table(column_headings, table_data)

    html = <<HEREDOC
    <div class="table-responsive">
    <table class="table thead-dark table-striped">
    <thead class="thead-dark">
      <tr>#{column_headings.map { |h| "<th>#{h}</th>"}.join}</tr>
    </thead>
    #{table_data}
    </table>
    </div>
HEREDOC
    html.html_safe
  end
end