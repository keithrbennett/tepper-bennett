class ReportMovies


  attr_reader :report_title, :ar_class


  def line_length
    year_column_length = 4 + 2  # 4 digit year + buffer
    Movie.max_code_length + year_column_length + Movie.max_name_length + 4
  end


  def title_indent(title)
    (line_length - title.length) / 2
  end


  def separator_line
    ('-' * line_length) + "\n"
  end


  def report_string
    report = StringIO.new

    report_by_order = ->(display_name, order) do
      report << separator_line
      title = "Movies in #{display_name} Order"
      indentation = ' ' * title_indent(title)
      report << "#{indentation}#{title}\n"
      report << separator_line
      report << "\n   Code         Year         Name\n\n"
      Movie.order(order).all.each { |record| report << record_report_string(record) << "\n" }
      report << "\n\n"
    end

    report_by_order.('Title', :name)
    report_by_order.('Year', :year)
    report.string
  end


  def record_report_string(record)
    '%-14s  %4d   %s' % [record.code, record.year, record.name]
  end

end