class Movie < ApplicationRecord

  has_and_belongs_to_many :songs

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.as_report_strings
    report = StringIO.new
    report << "          Movies\n\n"
    report << '   Code        Year    Name'
    report << "\n\n"
    all.each { |record| report << record.as_report_string << "\n" }
    report.string
  end

  def as_report_string
    '%-14s  %4.4d  %s' % [code, year, name]
  end



end
