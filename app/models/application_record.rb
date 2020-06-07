class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.max_code_length
    12
  end
end
