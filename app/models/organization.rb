class Organization < ApplicationRecord

  has_and_belongs_to_many :songs

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.as_report_strings
    report = StringIO.new
    report << "          Organizations\n\n"
    report << '   Code           Name'
    report << "\n\n"
    all.each { |record| report << record.as_report_string << "\n" }
    report.string
  end

  def as_report_string
    '%-14s %s' % [code, name]
  end


end
