class BaseReport

  TITLE_TIME_LENGTH = 34

  def title_with_gen_date(title)
    title + ' -- Generated ' + Time.now.utc.strftime('%Y-%m-%d %H:%M UTC')
  end

  def separator_line
    @separator_line ||= ('-' * [line_length, (report_title.length + TITLE_TIME_LENGTH)].max)
  end

  def title_indentation
    title_length_incl_timestamp = report_title.length + TITLE_TIME_LENGTH
    ' ' * [((line_length - title_length_incl_timestamp) / 2), 0].max
  end

  def title_banner
    <<~HEREDOC
    #{separator_line}
    #{title_indentation}#{title_with_gen_date(report_title)}
    #{separator_line}


    HEREDOC
  end
end