module Reports
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
      render partial: 'reports/song_rights_admins', locals: { records: records }
    end

    def to_raw_text
      TextReports::SongRightsAdminsTextReport.new(records).report_string
    end
  end
end
