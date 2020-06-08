# Produces a report string containing the codes and names for the specified ActiveRecord class.
class CodeNameReport

  attr_reader :report_title, :ar_class

  def initialize(ar_class)
    @report_title = ar_class.to_s + " Codes/Names"
    @ar_class     = ar_class
  end


  def line_length
    ar_class.max_code_length + ar_class.max_name_length + 2
  end


  def title_indent(title)
    (line_length - title.length) / 2
  end


  def separator_line
    ('-' * line_length) + "\n"
  end


  def report_string
    report = StringIO.new

    indentation = ' ' * title_indent(report_title)
    report << separator_line
    report << "%s%-s\n" % [indentation, report_title]
    report << separator_line
    report << "\n   Code           Name\n\n"
    ar_class.order(:name).all.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    '%-14s %s' % [record.code, record.name]
  end

end
