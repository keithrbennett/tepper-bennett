module Reports; module TextReports
  class BaseTextReport

    TITLE_TIME_LENGTH = 34

    def date_time_string
      Time.now.utc.strftime('%Y-%m-%d %H:%M UTC')
    end

    def title_with_gen_date(title)
      title + ' -- Generated ' + date_time_string
    end

    def separator_line
      @separator_line ||= ('-' * [line_length, (title.length + TITLE_TIME_LENGTH)].max)
    end

    def title_indentation
      title_length_incl_timestamp = title.length + TITLE_TIME_LENGTH
      ' ' * [((line_length - title_length_incl_timestamp) / 2), 0].max
    end

    def title_banner
      <<~HEREDOC
      #{separator_line}
      #{title_indentation}#{title_with_gen_date(title)}
      #{separator_line}
  
  
      HEREDOC
    end

    def build_report_hash(data)
      @report_data  = {
          'title' => @report_title,
          'generation_time' => date_time_string,
          'data' => data
      }
    end

    def attr_hash(record, attributes)
      attributes.each_with_object({}) do |attr, attr_hash|
        attr_hash[attr] = record[attr]
      end
    end


    def to_json
      JSON.pretty_generate(@report_data)
    end


    def to_yaml
      @report_data.to_yaml
    end
  end

end; end
