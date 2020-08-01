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

    locals = {
        records: records,
        secondary_key: secondary_key,
        headings: headings,
    }
    render(partial: 'reports/has_many_report', locals: locals)
  end


  def to_raw_text
    text_report_class_name.new(records).report_string
  end
end