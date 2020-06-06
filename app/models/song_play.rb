class SongPlay < ApplicationRecord

  belongs_to :song
  has_and_belongs_to_many :performers

  def self.as_report_strings
    report = StringIO.new
    report << "                                           Song Plays\n\n"
    report << 'YouTube Key  Song Code     Perf Code      Song Title                                 Performer Title                 URL'
    report << "\n\n"
    all.each { |record| report << record.as_report_string << "\n" }
    report.string
  end

  def as_report_string
    performer = performers.first
    '%-10s  %-12s  %-12s   %-40.40s   %-40.40s  %s' % \
        [youtube_key, song.code, performer.code, song.name, performer.name, url]
  end


end
