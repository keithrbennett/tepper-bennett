class SongRightsAdminsReport < BaseReport

  attr_reader :records

  def initialize
    @report_type = 'song_rights_admins'
  end

  def populate
    @records = Song.order(:name).map do |song|
      rights_admins = song.rights_admin_orgs.order(:name)
      {
          code: song.code,
          name: song.name,
          rights_admins: pluck_to_hash(rights_admins, :code, :name),
      }
    end
  end

  def to_html
    headings = ['Song Code', 'Song Name', 'RA Code', 'Rights Admin Name']
    html_data = records.map do |r|
      [
          r[:code],
          r[:name],
          r[:rights_admins].pluck(:code).join("<br/>"),
          r[:rights_admins].pluck(:name).join("<br/>"),
      ]
    end
    html_report_table(headings, html_data)
  end


  def to_raw_text
    SongRightsAdminsTextReport.new(records).report_string
  end
end
