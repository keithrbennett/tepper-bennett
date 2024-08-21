# frozen_string_literal: true

require 'find'
require 'uri'

# Finds all HTTPS URLs in the passed file mask
class ErbLinkFinder
  def self.call(file_mask)
    files = Dir[file_mask]
    links = []
    files.each do |file|
      File.foreach(file) do |line|
        URI.extract(line, ['https']).each do |url|
          cleaned_url = url.gsub(/['"]+/, '')  # Remove trailing single quotes, double quotes, etc.
          # Ensure parentheses are only stripped if they are not part of a valid URL
          cleaned_url = cleaned_url.gsub(/\)$/, '') unless cleaned_url.match?(/\(.*\)/)
          links << cleaned_url
        end
      end
    end
    links.uniq.sort
  end
end

# Example usage:
# root_dir = File.join(Dir.pwd, 'app', 'views', '**', '*.erb')
# links = ErbLinkFinder.call(root_dir)
# puts "Found links: #{links.join(', ')}"