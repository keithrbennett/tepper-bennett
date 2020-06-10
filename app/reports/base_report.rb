class BaseReport

  def title_with_gen_date(title)
    title + ' -- Generated ' + Time.now.utc.strftime('%Y-%m-%d %l:%M UTC')
  end

  def separator_line
    ('-' * [line_length, report_title.length].max) + "\n"
  end

  def title_indentation
    ' ' * [(line_length - report_title.length) / 2, 0].max
  end
end