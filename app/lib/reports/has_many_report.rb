class HasManyReport < BaseReport


  attr_reader :records, :title, :primary_ar_class, :secondary_ar_class, :secondary_key, :text_report_class_name


  def initialize(records:, title:, primary_ar_class:, secondary_ar_class:, text_report_class_name:)
    @records = records
    @title = title
    @primary_ar_class = primary_ar_class
    @secondary_ar_class = secondary_ar_class
    @text_report_class_name = text_report_class_name
    @secondary_key = secondary_ar_class.name.downcase.pluralize.to_sym
  end


  def to_html
    html = StringIO.new

    headings = -> do
      %w(Code Name).map { |field_name| "#{secondary_ar_class.name.capitalize} #{field_name}" }
    end

    append_row = ->(primary) do
      name = primary[:name]
      name = (name == name.downcase) ? name.capitalize : name
      html << "<h2>#{name}</h2>\n"
      secondaries = primary[secondary_key]
      if secondaries.empty?
        html << "[No songs for this #{primary_ar_class.name.downcase}]</br>\n"
      else
        data = secondaries.map { |primary| [primary[:code], primary[:name]] }
        table_data = records_to_html_table_data(data)
        html << "<br/>\n" << html_report_table(headings.(), table_data)
      end
      html << "<br/><br/>\n"
    end

    records.each { |primary| append_row.(primary) }
    html.string.html_safe
  end


  def to_raw_text
    text_report_class_name.new(records).report_string
  end
end