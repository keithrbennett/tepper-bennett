  module Reports
  class BaseReport

    attr_reader :field_names

    def render(*args)
      ApplicationController.renderer.render(*args)
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


    def pluck_to_hash(enumerable, *field_names)
      enumerable.pluck(*field_names).map do |field_values|
        field_names.zip(field_values).each_with_object({}) do |(key, value), result_hash|
          result_hash[key] = value
        end
      end
    end

    def tooltip_td(text, tooltip_text)
      %Q{<td alt="#{tooltip_text}" title="#{tooltip_text}" data-toggle="tooltip" data-placement="bottom">#{text}</td>}.html_safe
    end

  end
end
