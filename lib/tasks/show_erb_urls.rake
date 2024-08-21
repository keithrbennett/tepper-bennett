# Rakefile
require_relative '../lib/erb_link_finder'

namespace :links do
  desc "Show all HTTPS URLs in .erb files"
  task :show_erb_urls do
    file_mask = File.join(Dir.pwd, 'app', 'views', '**', '*.erb')
    links = ErbLinkFinder.call(file_mask)
    puts "Found links:\n\n#{links.join("\n")}"
  end
end
