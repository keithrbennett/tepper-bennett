# Produces a report string containing the codes and names for the specified ActiveRecord class.
class CodeNameReport < BaseReport

  attr_reader :report_title, :ar_class

  def initialize(ar_class)
    @report_title = ar_class.to_s + " Codes/Names"
    @ar_class     = ar_class
    build_report_hash(generate_report_data)
  end


  def generate_report_data
    ar_class.order(:name).all.map do |record|
      { 'code' => record['code'], 'name' => record['name'] }
    end
  end


  def line_length
    ar_class.max_code_length + ar_class.max_name_length + 2
  end


  def report_string
    report = StringIO.new
    report << title_banner << "   Code           Name\n\n"
    @report_data['data'].each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    '%-14s %s' % [record['code'], record['name']]
  end


  def to_text
    report_string
  end


  def to_json
    JSON.pretty_generate(@report_data)
  end


  def to_yaml
    @report_data.to_yaml
  end

end
