# This script seeds the data base with all the data it needs for the application.
# Data is not modified by the application.
# Run rails db:reset to recreate the DB with this data

def read_data(data_type)
  # Read a file from the same directory as this file, and parse the YAML to create a Ruby object.
  YAML.load_file(File.join(File.dirname(__FILE__), "#{data_type}.yml"))
end


def add_genres
  genres = read_data('genres')
  print "Adding #{genres.size} genres..."
  genres.each { |genre| Genre.create!(code: genre, name: genre) }
  puts 'done.'
end


def add_writers
  writers = read_data('writers')
  print "Adding #{writers.count} writers..."
  writers.each { |writer| Writer.create!(code: writer[:code], name: writer[:name]) }
  puts 'done.'
end


def add_movies
  movies = read_data('movies')
  print "Adding #{movies.size} movies..."
  movies.each { |m| Movie.create!(code: m[:code], year: m[:year], imdb_key: m[:imdb_key], name: m[:name]) }
  puts 'done.'
end


def add_performers
  performers = read_data('performers')
  print "Adding #{performers.size} performers..."
  performers.each { |p| Performer.create!(code: p[:code], name: p[:name])}
  puts 'done.'
end


def add_organizations
  organizations = read_data('organizations')
  print "Adding #{organizations.size} organizations..."
  organizations.each { |o| Organization.create!(code: o[:code], name: o[:name]) }
  puts 'done.'
end


def default_writer_codes
  @default_writers ||= %w{tepper bennett}
end


def add_song(code:, name:, performers: [], genres: [], writers: default_writer_codes, movie: nil)
  movie_obj = nil
  if movie.present?
    movie_obj = Movie.get_by_code!(movie)
    raise "Movie for code '#{movie}' not found." if movie_obj.nil?
  end
  
  db_song = Song.new(code: code, name: name, writers: writers.map { |code| Writer.get_by_code!(code) }, movie: movie_obj)

  performers ||= []
  performers.uniq.each do |code|
    performer = Performer.get_by_code!(code)
    raise "Performer for code '#{code}' not found." if performer.nil?
    db_song.performers << performer
  end

  genres ||= []
  genres.uniq.each do |code|
    genre = Genre.get_by_code!(code)
    raise "Genre for code '#{code}' not found." if genre.nil?
    db_song.genres << genre
  end

  db_song.save!
end


def add_elvis_songs
  songs = read_data('elvis-songs')

  add_elvis_and_movie_genres = -> do
    Song.all.select { |song| song.performer_codes.include?('elvis') }.each do |song|
      song.add_genre('elvis')
      song.add_genre('movie') unless song['code'] == 'old-sake'
    end
  end

  validate_code_lengths = -> do
  songs_with_long_codes = songs.map { |h| h[:code] }.select { |code| code.length > 12 }
    unless songs_with_long_codes.empty?
      raise "Song codes too long: #{songs_with_long_codes}"
    end
  end

  add_songs = -> do
    print "Adding #{songs.size} Elvis songs..."
    songs.each do |s|
      performers = %w{elvis}
      case s[:code]
      when 'l-cowboy'
        performers << 'fisch-sauer'
      when 'lady-loves'
        performers << 'ann-margret'
      when 'shrimp'
        performers << 'naysayer'
      end

      add_song(code: s[:code], name: s[:name], performers: performers, genres: s[:genres], movie: s[:movie])
    end
  end

  # ----
  validate_code_lengths.()
  add_songs.()
  add_elvis_and_movie_genres.()
  puts 'done.'
end


def add_non_elvis_songs

  songs = read_data('non-elvis-songs')
  print "Adding #{songs.count} non-Elvis songs..."
  songs.each do |s|
    s[:writers] ||= default_writer_codes
    add_song(code: s[:code], name: s[:name], performers: s[:performers], genres: s[:genres], movie: s[:movie], writers: s[:writers])
  end

  puts 'done.'
end

def add_song_plays

  plays = read_data('song-plays')
  puts "Adding #{plays.count} song plays..."

  plays.each do |play|
    song_code = play[:song_code]
    song = Song.get_by_code!(song_code)
    performer_codes = Array(play[:performer_codes])
    performers = performer_codes.map { |code| Performer.get_by_code!(code) }
    code = song_code + '.' + performer_codes.first
    youtube_key = play[:youtube_key]

    begin
      SongPlay.create!(song: song, performers: performers, youtube_key: youtube_key, code: code)
    rescue => e
      $stderr.puts "Error adding song play code ''#{code}''"
      raise
    end
  end

  puts 'done.'
end


def add_rights_admin_links
  # TODO: who is kiss-fire's other rights admin?

  add_data = ->(org_code, song_codes) do
    org = Organization.get_by_code!(org_code)
    song_codes.each do |code|
      song = Song.get_by_code!(code)
      song.rights_admin_orgs << org
    end
  end

  warner_song_codes = read_data('warner-song-codes')
  add_data.('warner',    warner_song_codes)

  universal_song_codes = read_data('universal-song-codes')
  add_data.('universal', universal_song_codes)
end


add_genres
add_writers
add_movies
add_performers
add_organizations
add_elvis_songs
add_non_elvis_songs
add_song_plays
add_rights_admin_links



