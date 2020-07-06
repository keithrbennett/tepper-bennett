require_relative 'code_name_text_report'

class SongsTextReport < CodeNameTextReport

  def initialize(records)
    super(Song, records)
  end

end
