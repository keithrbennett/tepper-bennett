# Rakefile

# Finds all HTTPS URLs in files in the specified filemask.
FIND_LINKS = ->(file_mask) do
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


namespace :links do
  desc "Show all HTTPS URLs in .erb files"
  task :show_erb_urls do
    file_mask = File.join(Dir.pwd, 'app', 'views', '**', '*.erb')
    links = FIND_LINKS.call(file_mask)
    puts "Found links:\n\n#{links.join("\n")}"
  end
end
