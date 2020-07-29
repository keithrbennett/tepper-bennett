class SongRightsAdminsReport < BaseReport

  attr_reader :records

  def initialize
    @records = Song.order(:name).map do |song|
      rights_admins = song.rights_admin_orgs.order(:name)
      {
          code: song.code,
          name: song.name,
          rights_admins: pluck_to_hash(rights_admins, :code, :name),
      }
    end
    @report_type = 'song_rights_admins'
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
    table_data = records_to_html_table_data(html_data)
    html_report_table(headings, table_data)
  end


  def to_raw_text
    SongRightsAdminsTextReport.new(records).report_string
  end
end
