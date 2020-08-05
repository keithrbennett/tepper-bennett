class RightsAdminSongsReport < BaseReport

  attr_reader :records

  def initialize
    @title = 'Rights Administrator Songs',
    @report_type = 'rights_admins'
  end

  def populate
    @records = Organization.order(:name).all.map do |org|
      {
          name: org.name,
          songs: pluck_to_hash(org.songs.order(:name), :code, :name)
      }
    end
  end

  def to_html
    render partial: 'reports/rights_admin_songs', locals: { records: records }
  end

  def to_raw_text
    RightsAdminSongsTextReport.new(records).report_string
  end
end