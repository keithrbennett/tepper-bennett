class HasManyReport < BaseReport


  attr_reader :records, :title, :primary_ar_class, :secondary_ar_class, :secondary_key, :text_report_class_name


  def initialize(title:, primary_ar_class:, secondary_ar_class:, text_report_class_name:)
    @title = title
    @primary_ar_class = primary_ar_class
    @secondary_ar_class = secondary_ar_class
    @text_report_class_name = text_report_class_name
    @secondary_key = secondary_ar_class.name.downcase.pluralize.to_sym
  end


  def to_html
    headings = %w(Code Name).map { |field_name| "#{secondary_ar_class.name.capitalize} #{field_name}" }

    fn_name = ->(primary) do
      n = primary[:name]
      n == n.downcase ? n : n.capitalize
    end

    html = StringIO.new

    records.each do |primary|
      name = fn_name.(primary)
      secondaries = primary[secondary_key].pluck(:code, :name)
      html << render_to_string(partial: 'reports/has_many_report', locals: { column_headings: headings, name: name, secondaries: secondaries })
    end
    html.string.html_safe
  end


  def to_raw_text
    text_report_class_name.new(records).report_string
  end
end