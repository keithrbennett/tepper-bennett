# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.tepper-bennett.com"
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.compress = true

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  
  # Add home page with high priority
  add '/', changefreq: 'daily', priority: 1.0
  
  # Add main sections
  add '/songs', changefreq: 'weekly', priority: 0.8
  add '/genres', changefreq: 'weekly', priority: 0.8
  add '/elvis', changefreq: 'weekly', priority: 0.8
  add '/resources', changefreq: 'weekly', priority: 0.7
  add '/reports', changefreq: 'monthly', priority: 0.6
  add '/inquiries', changefreq: 'monthly', priority: 0.5
  
  # Dynamically add all songs
  # Uncomment and adjust based on your model structure
  # Song.find_each do |song|
  #   add song_path(song), lastmod: song.updated_at, priority: 0.7
  # end
  
  # Dynamically add all genres
  # Uncomment and adjust based on your model structure
  # Genre.find_each do |genre|
  #   add genre_path(genre), lastmod: genre.updated_at, priority: 0.7
  # end
  
  # Add any additional static pages
  # add '/about', changefreq: 'monthly', priority: 0.5
  # add '/contact', changefreq: 'monthly', priority: 0.5
  # add '/privacy', changefreq: 'yearly', priority: 0.3
  # add '/terms', changefreq: 'yearly', priority: 0.3
  
  # Exclude specific pages like admin or login
  # These are automatically hidden because we only include what's explicitly listed,
  # but you can use SitemapGenerator::Interpreter.send :include_or_exclude to exclude specific paths
end
