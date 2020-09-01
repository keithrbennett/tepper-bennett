class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.max_code_length
    12
  end

  # This will be overridden in some subclasses, such as Genre.
  def self.max_name_length
    40
  end

  def self.get_by_code!(code)
    object = find_by_code(code)
    if object.nil?
      raise "Could not find #{to_s} instance for code '#{code}'."
    end
    object
  end
end
