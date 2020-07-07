require_relative 'base_text_report'

class GenresTextReport < BaseTextReport

  attr_reader :title, :line_length

  def initialize
    @line_length = [Genre.max_code_length, Genre.max_name_length].sum + 6
    @report_title = 'Genres'
    build_report_hash(data)
  end


  def data
    @data ||= Genre.order(:name).all.map do |record|
      { 'code' => record['code'], 'name' => record['name'], 'song_count' => record.songs.count }
    end
  end


  def heading
    '%-*s  %-*s  %-s' %
        [Genre.max_code_length,      '   Code',
         Genre.max_name_length,      'Name',
         'Song Count']
  end


  def report_string
    report = StringIO.new
    report << title_banner << "#{heading}\n\n"
    data.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    '%-*s  %-*s     %3d' %
        [Genre.max_code_length, record['code'], Genre.max_name_length, record['name'], record['song_count']]
  end

end