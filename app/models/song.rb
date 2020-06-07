class Song < ApplicationRecord

  has_and_belongs_to_many :movies
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :performers
  has_and_belongs_to_many :writers
  has_and_belongs_to_many :rights_admin_orgs, class_name: 'Organization'
  has_many :song_plays

  def self.max_name_length
    50
  end

  validates_length_of :code, maximum: max_code_length
  validates_length_of :name, maximum: max_name_length

  validates :name, presence: true
  validates :name, uniqueness: true


  def self.as_report_string
    report = StringIO.new
    report << "          Songs\n\n"
    report << '%-*s  %-*s  %-*s  %-*s' %
        [Song.max_code_length,      '   Code',      Song.max_name_length,      'Name',
         Performer.max_code_length, 'Perf Code', Performer.max_name_length, 'Performer Name']
    report << "\n\n"
    all.each { |record| report << record.as_report_string << "\n" }
    report.string
  end


  def as_report_string

    @report_string_continuation_indent ||= Song.max_code_length + Song.max_name_length + 4

    sio = StringIO.new
    sio << '%-*s  %-*s  %-*s  %s' %
        [Song.max_code_length, code, Song.max_name_length, name,
         Song.max_code_length, performers.first.code, performers.first.name]
    performers[1..-1].each do |performer|
      sio << ("\n%-*s%-*s  %s" %
          [@report_string_continuation_indent, '', Song.max_code_length, performer.code, performer.name])
    end
    sio.string
  end



end
