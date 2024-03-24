module Reports; module TextReports
  class RightsAdminSongsTextReport < HasManyTextReport

    def initialize(records)
      super(records, 'Rights Administrator Songs', Organization, Song)
    end
  end
end end
