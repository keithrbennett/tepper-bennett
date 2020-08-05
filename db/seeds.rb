# This script seeds the data base with all the data it needs for the application.
# Data is not modified by the application.
# Run rails db:reset to recreate the DB with this data

def add_genres
  genres = %w(bluegrass blues children country elvis funny hit movie rock romantic tv)
  print "Adding #{genres.size} genres..."
  genres.each { |genre| Genre.create!(code: genre, name: genre) }
  puts 'done.'
end


def add_writers
  writers = [
      { code: 'bennett'  , name: 'Roy C. Bennett' },
      { code: 'tepper'   , name: 'Sid Tepper' },
      { code: 'shayne'   , name: 'Gloria Shayne' },
      { code: 'kent'     , name: 'Arthur Kent' },
  ]
  print "Adding #{writers.count} writers..."
  writers.each { |writer| Writer.create!(code: writer[:code], name: writer[:name]) }
  puts 'done.'
end


def add_movies
  movies = [
      { code:  'lov-you',    year: 1957, imdb_key: 'tt0050659', name: "Loving You" },
      { code:  'k-creole',   year: 1958, imdb_key: 'tt0051818', name: "King Creole" },
      { code:  'flam-star',  year: 1960, imdb_key: 'tt0053825', name: "Flaming Star" },
      { code:  'g-i-blues',  year: 1960, imdb_key: 'tt0053848', name: "G. I. Blues" },
      { code:  'b-hawaii',   year: 1961, imdb_key: 'tt0054692', name: "Blue Hawaii" },
      { code:  'foll-dream', year: 1962, imdb_key: 'tt0055992', name: "Follow That Dream" },
      { code:  'girls',      year: 1962, imdb_key: 'tt0056023', name: "Girls! Girls! Girls!" },
      { code:  'young-ones', year: 1962, imdb_key: 'tt0055626', name: "The Young Ones (USA: Wonderful to Be Young!)" },
      { code:  'acapulco',   year: 1963, imdb_key: 'tt0057083', name: "Fun in Acapulco" },
      { code:  'w-fair',     year: 1963, imdb_key: 'tt0057191', name: "It Happened at the World's Fair" },
      { code:  'girl-happy', year: 1964, imdb_key: 'tt0059224', name: "Girl Happy" },
      { code:  'k-cousins',  year: 1964, imdb_key: 'tt0057227', name: "Kissin' Cousins" },
      { code:  'roust',      year: 1964, imdb_key: 'tt0058534', name: "Roustabout" },
      { code:  'vegas',      year: 1964, imdb_key: 'tt0058725', name: "Viva Las Vegas" },
      { code:  'h-scarum',   year: 1965, imdb_key: 'tt0059255', name: "Harum Scarum" },
      { code:  'f-johnny',   year: 1966, imdb_key: 'tt0060429', name: "Frankie and Johnny" },
      { code:  'paradise',   year: 1966, imdb_key: 'tt0059563', name: "Paradise, Hawaiian Style" },
      { code:  'spinout',    year: 1966, imdb_key: 'tt0061015', name: "Spinout" },
      { code:  'clambake',   year: 1967, imdb_key: 'tt0061489', name: "Clambake" },
      { code:  'd-trouble',  year: 1967, imdb_key: 'tt0061595', name: "Double Trouble" },
      { code:  'speedway',   year: 1968, imdb_key: 'tt0063634', name: "Speedway" },
      { code:  's-a-joe',    year: 1968, imdb_key: 'tt0063643', name: "Stay Away, Joe" },
  ]
  print "Adding #{movies.size} movies..."
  movies.each { |m| Movie.create!(code: m[:code], year: m[:year], imdb_key: m[:imdb_key], name: m[:name]) }
  puts 'done.'
end


def add_performers
  performers = [
      { code: "a-mooney"      , name: "Art Mooney & His Orchestra" },
      { code: "a-prysock"     , name: "Arthur Prysock" },
      { code: "a-sherman"     , name: "Allan Sherman" },
      { code: "ames-bros"     , name: "The Ames Brothers" },
      { code: "andy-wms"      , name: "Andy Williams" },
      { code: "anne-lloyd"    , name: "Anne Lloyd, Sandpiper Singers, Mitch Miller & Orchestra" },
      { code: "ann-margret"   , name: "Ann-Margret" },
      { code: "b-gordon"      , name: "Barry Gordon" },
      { code: "beatles"       , name: "The Beatles" },
      { code: "ben-mill"      , name: "Tex Beneke and The Miller Orchestra" },
      { code: "bert-kmft"     , name: "Bert Kaempfert and His Orchestra" },
      { code: "c-francis"     , name: "Connie Francis" },
      { code: "clf-rich"      , name: "Cliff Richards" },
      { code: "dean-martin"   , name: "Dean Martin" },
      { code: "della-reese"   , name: "Della Reese" },
      { code: "eartha-kitt"   , name: "Eartha Kitt" },
      { code: "ed-albert"     , name: "Eddie Albert" },
      { code: "elvis"         , name: "Elvis Presley" },
      { code: "fisch-sauer"   , name: "Denis Fischer & Carsten Sauer" },
      { code: "geo-gibbs"     , name: "Georgia Gibbs" },
      { code: "guy-lomb"      , name: "Guy Lombardo And His Royal Canadians" },
      { code: "h-hermits"     , name: "Herman's Hermits" },
      { code: "homer-jethro"  , name: "Homer and Jethro" },
      { code: "ink-spots"     , name: "The Ink Spots" },
      { code: "jay-amer"      , name: "Jay and the Americans" },
      { code: "jeff-beck"     , name: "Jeff Beck" },
      { code: "kilburn"       , name: "Kilburn and the High Roads" },
      { code: "louis-arm"     , name: "Louis Armstrong" },
      { code: "m-robbins"     , name: "Marty Robbins" },
      { code: "mickey-katz"   , name: "Mickey Katz" },
      { code: "moscow-jazz"   , name: "Moscow City Jazz Band" },
      { code: "n-wilson"      , name: "Nancy Wilson" },
      { code: "naysayer"      , name: "Naysayer" },
      { code: "p-como"        , name: "Perry Como" },
      { code: "plain-white"   , name: "Plain White T's" },
      { code: "r-clooney"     , name: "Rosemary Clooney" },
      { code: "r-conniff"     , name: "Ray Conniff Singers" },
      { code: "r-goulet"      , name: "Robert Goulet" },
      { code: "rob-schneid"   , name: "Rob Schneider" },
      { code: "sinatra"       , name: "Frank Sinatra" },
      { code: "stargazers"    , name: "The Stargazers" },
      { code: "sugarland"     , name: "Sugarland" },
      { code: "v-monroe"      , name: "Vaughn Monroe" },
      { code: "vic-choir"     , name: "Victoria Junior College Choir (Singapore)" },
      { code: "vic-dana"      , name: "Vic Dana" },
      { code: "w-newton"      , name: "Wayne Newton" },
  ]
  print "Adding #{performers.size} performers..."
  performers.each { |p| Performer.create!(code: p[:code], name: p[:name])}
  puts 'done.'
end


def add_organizations
  organizations = [
      { code: "emi-uk"        , name: "EMI (United Kingdom)" },
      { code: "emi-us"        , name: "EMI (United States)" },
      { code: "example"       , name: "Example Music" },
      { code: "kobalt"        , name: "Kobalt Music Group" },
      { code: "mem-lane"      , name: "Memory Lane" },
      { code: "raleigh"       , name: "Peter Raleigh Music" },
      { code: "sony"          , name: "Sony ATV Music" },
      { code: "univ"          , name: "Universal Music" },
      { code: "warner"        , name: "Warner Chappel" },
  ]
  print "Adding #{organizations.size} organizations..."
  organizations.each { |o| Organization.create!(code: o[:code], name: o[:name]) }
  puts 'done.'
end


def default_writers
  @default_writers ||= [Writer.find_by_code('tepper'), Writer.find_by_code('bennett')]
end


def add_song(code:, name:, performers: [], genres: [], writers: default_writers, movies: nil)
  db_song = Song.new(code: code, name: name, writers: writers)

  performers ||= []
  performers.uniq.each do |code|
    performer = Performer.find_by_code(code)
    raise "Performer for code '#{code}' not found." if performer.nil?
    db_song.performers << performer
  end

  genres ||= []
  genres.uniq.each do |code|
    genre = Genre.find_by_code(code)
    raise "Genre for code '#{code}' not found." if genre.nil?
    db_song.genres << genre
  end

  movies ||= []
  movies.uniq.each do |code|
    movie = Movie.find_by_code(code)
    raise "Movie for code '#{code}' not found." if movie.nil?
    db_song.movies << movie
  end

  db_song.save!
end


def add_elvis_songs
  songs = [
      { code: "boy-like-me"   , name: "A Boy Like Me, A Girl Like You" ,                          movies: %w{girls} },
      { code: "cane-collar"   , name: "A Cane and A High Starched Collar",                        movies: %w{flam-star} },
      { code: "h-everything"  , name: "A House That Has Everything",  genres: %w{romantic},       movies: %w{clambake} },
      { code: "all-i-am"      , name: "All That I Am", genres: %w{romantic},                      movies: %w{spinout} },
      { code: "am-i-ready"    , name: "Am I Ready", genres: %w{romantic},                         movies: %w{spinout}  },
      { code: "angel"         , name: "Angel", genres: %w{romantic},                              movies: %w{foll-dream} },
      { code: "b-b-blues"     , name: "Beach Boy Blues", genres: %w{blues},                       movies: %w{b-hawaii} },
      { code: "beg-luck"      , name: "Beginners Luck", genres: %w{romantic},                     movies: %w{f-johnny} },
      { code: "confidence"    , name: "Confidence",                                               movies: %w{clambake} },
      { code: "drums-isles"   , name: "Drums of the Islands",                                     movies: %w{paradise} },
      { code: "earth-boy"     , name: "Earth Boy",                                                movies: %w{girls} },
      { code: "five-heads"    , name: "Five Sleepy Heads",                                        movies: %w{speedway} },
      { code: "millionth"     , name: "For the Millionth and Last Time",                          movies: %w{foll-dream} },
      { code: "ft-laud"       , name: "Fort Lauderdale Chamber of Commerce",                      movies: %w{girl-happy} },
      { code: "g-i-blues"     , name: "G. I. Blues", genres: %w{blues},                           movies: %w{g-i-blues} },
      { code: "h-sunset"      , name: "Hawaiian Sunset",                                          movies: %w{b-hawaii} },
      { code: "one-girl"      , name: "I Love Only One Girl",                                     movies: %w{d-trouble} },
      { code: "isl-love"      , name: "Island of Love", genres: %w{romantic},                     movies: %w{b-hawaii} },
      { code: "wond-world"    , name: "It's a Wonderful World",                                   movies: %w{roust} },
      { code: "ito-eats"      , name: "Ito Eats",                                                 movies: %w{b-hawaii} },
      { code: "old-sake"      , name: "Just for Old Time Sake",                                   movies: nil }, # *not* in a movie!
      { code: "kismet"        , name: "Kismet",                                                   movies: %w{h-scarum} },
      { code: "l-cowboy"      , name: "Lonesome Cowboy",                                          movies: %w{lov-you} },
      { code: "mexico"        , name: "Mexico",                                                   movies: %w{acapulco} },
      { code: "mine"          , name: "Mine",                                                     movies: %w{speedway} },
      { code: "n-orleans"     , name: "New Orleans",                                              movies: %w{k-creole} },
      { code: "once-enough"   , name: "Once is Enough",                                           movies: %w{k-cousins} },
      { code: "petunia"       , name: "Petunia, the Gardener's Daughter", genres: %w{romantic},   movies: %w{f-johnny} },
      { code: "puppet"        , name: "Puppet on a String", genres: %w{romantic},                 movies: %w{girl-happy} },
      { code: "relax"         , name: "Relax",                                                    movies: %w{w-fair} },
      { code: "shop-arnd"     , name: "Shoppin' Around",                                          movies: %w{g-i-blues} },
      { code: "sl-sand"       , name: "Slicin' Sand",                                             movies: %w{b-hawaii} },
      { code: "smorgasbord"   , name: "Smorgasbord",                                              movies: %w{spinout} },
      { code: "shrimp"        , name: "Song of the Shrimp",                                       movies: %w{girls} },
      { code: "stay-away"     , name: "Stay Away",                                                movies: %w{s-a-joe} },
      { code: "take-me-fair"  , name: "Take Me to the Fair",                                      movies: %w{w-fair} },
      { code: "bullfighter"   , name: "The Bullfighter Was a Lady", genres: %w{romantic},         movies: %w{acapulco} },
      { code: "lady-loves"    , name: "The Lady Loves Me", genres: %w{romantic},                  movies: %w{vegas} },
      { code: "walls-ears"    , name: "The Walls Have Ears",                                      movies: %w{girls} },
      { code: "vino"          , name: "Vino, Dinero y Amor",                                      movies: %w{acapulco} },
      { code: "west-union"    , name: "Western Union",                                            movies: %w{speedway} },
      { code: "wheels-heels"  , name: "Wheels on My Heels",                                       movies: %w{roust} },
  ]

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

      add_song(code: s[:code], name: s[:name], performers: performers, genres: s[:genres], movies: s[:movies])
    end
  end

  # ----
  validate_code_lengths.()
  add_songs.()
  add_elvis_and_movie_genres.()
  puts 'done.'
end


def add_non_elvis_songs

  songs = [
      { code: "bagel-lox"     , name: "Bagels & Lox",                              performers: %w(rob-schneid) },
      { code: "run-back-me"   , name: "Don't Come Running Back to Me" ,            performers: %w(n-wilson),    genres: %w{romantic} },
      { code: "eggbert"       , name: "Eggbert, The Easter Egg" ,                  performers: %w(r-clooney),   genres: %w{children} },
      { code: "glad"          , name: "Glad All Over" ,                            performers: %w(beatles jeff-beck) },
      { code: "bye-boys"      , name: "Goodbye Boys, Goodbye" ,                    performers: %w(jay-amer) },
      { code: "crush-ny"      , name: "I've Got a Crush on New York Town" ,        performers: %w(c-francis) },
      { code: "long-way"      , name: "It's a Long Way from Your House to My House" , performers: %w(sinatra),  genres: %w{romantic} },
      { code: "jenny-kiss"    , name: "Jenny Kissed Me" ,                          performers: %w(ed-albert),   genres: %w{romantic} },
      { code: "kewpie-doll"   , name: "Kewpie Doll" ,                              performers: %w(p-como) },
      { code: "kiss-fire"     , name: "Kiss of Fire" ,                             performers: %w(a-sherman louis-arm mickey-katz),   genres: %w{ hit romantic} },
      { code: "n-for-xmas"    , name: "Nuttin' for Christmas" ,                    performers: %w(a-mooney b-gordon eartha-kitt homer-jethro plain-white sugarland),    genres: %w{children hit} },
      { code: "red-roses"     , name: "Red Roses for a Blue Lady" ,                performers: %w(andy-wms bert-kmft dean-martin moscow-jazz p-como r-conniff sinatra vic-choir vic-dana v-monroe w-newton), genres: %w{hit romantic} },
      { code: "santa-daddy"   , name: "Santa Claus Looks Just Like Daddy" ,        performers: %w(a-mooney b-gordon),    genres: %w{children} },
      { code: "ssss-heart"    , name: "Say Something Sweet to Your Sweetheart" ,   performers: %w(ink-spots),   genres: %w{hit romantic} },
      { code: "soft-love"     , name: "Softly My Love" ,                           performers: %w(della-reese), genres: %w{romantic} },
      { code: "smr-sounds"    , name: "Summer Sounds" ,                            performers: %w(r-goulet) },
      { code: "stair-love"    , name: "Stairway of Love" ,                         performers: %w(m-robbins) },
      { code: "stop-think"    , name: "Stop and Think it Over" ,                   performers: %w(p-como) },
      { code: "suzy-snow"     , name: "Suzy Snowflake" ,                           performers: %w(r-clooney),   genres: %w{children} },
      { code: "tear-rain"     , name: "Teardrops in the Rain" ,                    performers: %w(a-prysock),   genres: %w{romantic} },
      { code: "train-ahchoo"  , name: "The Little Train Who Said 'Ah Choo" ,       performers: %w(anne-lloyd),  genres: %w{children} },
      { code: "nty-lady"      , name: "The Naughty Lady of Shady Lane" ,           performers: %w(ames-bros),   genres: %w{funny hit} },
      { code: "woodchuck"     , name: "The Woodchuck Song" ,                       performers: %w(ben-mill) },
      { code: "young-ones"    , name: "The Young Ones" ,                           performers: %w(clf-rich),    genres: %w{hit movie tv}, movies: %w{young-ones} },
      { code: "tr-light"      , name: "Travelling Light" ,                         performers: %w(clf-rich h-hermits jay-amer), genres: %w{} },
      { code: "t-t-fingers"   , name: "Twenty Tiny Fingers" ,                      performers: %w(kilburn stargazers),  genres: %w{children} },
      { code: "when-arms"     , name: "When the Boy (Girl) in Your Arms" ,         performers: %w(c-francis),   genres: %w{romantic} },
      { code: "ww-young"      , name: "Wonderful World of the Young" ,             performers: %w(andy-wms clf-rich) },
  ]

  print "Adding #{songs.count} non-Elvis songs..."
  songs.each do |s|
    add_song(code: s[:code], name: s[:name], performers: s[:performers], genres: s[:genres], movies: s[:movies])
  end
  puts 'done.'
end

def add_song_plays

  plays = [
      { song_code: 'all-i-am'      , performer_codes: 'elvis'         , youtube_key: 'ireqvLFf08A' },
      { song_code: 'am-i-ready'    , performer_codes: 'elvis'         , youtube_key: 'E2J13o-RsxA' },
      { song_code: 'angel'         , performer_codes: 'elvis'         , youtube_key: '7RQuoPVMPT0' },
      { song_code: 'b-b-blues'     , performer_codes: 'elvis'         , youtube_key: 'Oq8BI8wB8Fk' },
      { song_code: 'bagel-lox'     , performer_codes: 'rob-schneid'   , youtube_key: 'dv4h8yU_N7o' },
      { song_code: 'beg-luck'      , performer_codes: 'elvis'         , youtube_key: '0IGp5zqeLLk' },
      { song_code: 'boy-like-me'   , performer_codes: 'elvis'         , youtube_key: 'cPQ5nnwYA2Q' },
      { song_code: 'bullfighter'   , performer_codes: 'elvis'         , youtube_key: 'kHTX0kU3sEo' },
      { song_code: 'bye-boys'      , performer_codes: 'jay-amer'      , youtube_key: 'BWyneW_A4_8' },
      { song_code: 'cane-collar'   , performer_codes: 'elvis'         , youtube_key: 'AE78rPjs6Mo' },
      { song_code: 'confidence'    , performer_codes: 'elvis'         , youtube_key: 'DE9Mc9cnBkg' },
      { song_code: 'crush-ny'      , performer_codes: 'c-francis'     , youtube_key: '0_Gycn0UJ9M' },
      { song_code: 'drums-isles'   , performer_codes: 'elvis'         , youtube_key: '4pXqiV-gbEk' },
      { song_code: 'earth-boy'     , performer_codes: 'elvis'         , youtube_key: 'h_i4Dmfowjs' },
      { song_code: 'eggbert'       , performer_codes: 'r-clooney'     , youtube_key: 'xkLGm9B60oY' },
      { song_code: 'five-heads'    , performer_codes: 'elvis'         , youtube_key: 'tZK2FcTjBsE' },
      { song_code: 'ft-laud'       , performer_codes: 'elvis'         , youtube_key: '3In-gZ5IL7s' },
      { song_code: 'g-i-blues'     , performer_codes: 'elvis'         , youtube_key: 'GkyjCJvHLsA' },
      { song_code: 'glad'          , performer_codes: 'beatles'       , youtube_key: 'ghag_1WCEuQ' },
      { song_code: 'glad'          , performer_codes: 'jeff-beck'     , youtube_key: 'OP0JNb6jfqU' },
      { song_code: 'h-everything'  , performer_codes: 'elvis'         , youtube_key: 'oh2wVSAnv98' },
      { song_code: 'h-sunset'      , performer_codes: 'elvis'         , youtube_key: 'ggjntl7S7oA' },
      { song_code: 'isl-love'      , performer_codes: 'elvis'         , youtube_key: '6RilIva9usA' },
      { song_code: 'ito-eats'      , performer_codes: 'elvis'         , youtube_key: 's1jb7o8GlrQ' },
      { song_code: 'jenny-kiss'    , performer_codes: 'ed-albert'     , youtube_key: 'Vf-9-rNHjcE' },
      { song_code: 'kewpie-doll'   , performer_codes: 'p-como'        , youtube_key: 'YJ9W47TIRR4' },
      { song_code: 'kismet'        , performer_codes: 'elvis'         , youtube_key: 'fnqC2I9QpIU' },
      { song_code: 'kiss-fire'     , performer_codes: 'geo-gibbs'     , youtube_key: 'mLpzfER6w3c' },
      { song_code: 'kiss-fire'     , performer_codes: 'louis-arm'     , youtube_key: 'gVxwN3Eaf_U' },
      { song_code: 'l-cowboy'      , performer_codes: 'elvis'         , youtube_key: 'DxComjngP2Q' },
      { song_code: 'l-cowboy'      , performer_codes: 'fisch-sauer'   , youtube_key: 'CrfwRBEEt_U' },
      { song_code: 'lady-loves'    , performer_codes: %w{elvis ann-margret}, youtube_key: 'Fv0bpfGfzls' },
      { song_code: 'long-way'      , performer_codes: 'sinatra'       , youtube_key: '7-tcw6w4Cj4' },
      { song_code: 'mexico'        , performer_codes: 'elvis'         , youtube_key: 'eCQrdpoBass' },
      { song_code: 'millionth'     , performer_codes: 'elvis'         , youtube_key: '0hhN13Qzl-Q' },
      { song_code: 'mine'          , performer_codes: 'elvis'         , youtube_key: 'GVMaaTaucsQ' },
      { song_code: 'n-for-xmas'    , performer_codes: 'b-gordon'      , youtube_key: '9J-hyQGmhlo' },
      { song_code: 'n-for-xmas'    , performer_codes: 'sugarland'     , youtube_key: 'VTjUZlLdmu8' },
      { song_code: 'n-orleans'     , performer_codes: 'elvis'         , youtube_key: 'A9C-oQ_mFSc' },
      { song_code: 'nty-lady'      , performer_codes: 'ames-bros'     , youtube_key: '9HxB7lxbTnI' },
      { song_code: 'old-sake'      , performer_codes: 'elvis'         , youtube_key: 'hyQSTzn58b0' },
      { song_code: 'once-enough'   , performer_codes: 'elvis'         , youtube_key: 'vxhe3_dTaBM' },
      { song_code: 'one-girl'      , performer_codes: 'elvis'         , youtube_key: 'ito_RR2kwS0' },
      { song_code: 'petunia'       , performer_codes: 'elvis'         , youtube_key: 'wuzbUsy6snc' },
      { song_code: 'puppet'        , performer_codes: 'elvis'         , youtube_key: 'RjWoFTu0W28' },
      { song_code: 'red-roses'     , performer_codes: 'andy-wms'      , youtube_key: 'HssRO5b_ED0' },
      { song_code: 'red-roses'     , performer_codes: 'bert-kmft'     , youtube_key: 'zt6WdnrAvpE' },
      { song_code: 'red-roses'     , performer_codes: 'dean-martin'   , youtube_key: 'drU6kuih41w' },
      { song_code: 'red-roses'     , performer_codes: 'guy-lomb'      , youtube_key: '_41H2cpTzNc' },
      { song_code: 'red-roses'     , performer_codes: 'moscow-jazz'   , youtube_key: '8-kRyR9c0uc' },
      { song_code: 'red-roses'     , performer_codes: 'sinatra'       , youtube_key: 'hu5qvkiQVjE' },
      { song_code: 'red-roses'     , performer_codes: 'vic-choir'     , youtube_key: 'me8aPqsQ620' },
      { song_code: 'red-roses'     , performer_codes: 'w-newton'      , youtube_key: 'HssRO5b_ED0' },
      { song_code: 'relax'         , performer_codes: 'elvis'         , youtube_key: 'DDH5xsR2b6g' },
      { song_code: 'run-back-me'   , performer_codes: 'n-wilson'      , youtube_key: 'QlzCpTEhhQM' },
      { song_code: 'santa-daddy'   , performer_codes: 'b-gordon'      , youtube_key: '0JCXmuNnrNc' },
      { song_code: 'shop-arnd'     , performer_codes: 'elvis'         , youtube_key: 'ADjm8yzYFW4' },
      { song_code: 'shrimp'        , performer_codes: 'elvis'         , youtube_key: '_GEKrj_ZloI' },
      { song_code: 'shrimp'        , performer_codes: 'naysayer'      , youtube_key: 'lGv1srhfOVw' },
      { song_code: 'sl-sand'       , performer_codes: 'elvis'         , youtube_key: 'ri3oqaZqAjo' },
      { song_code: 'smorgasbord'   , performer_codes: 'elvis'         , youtube_key: 'PzGLzYnSNes' },
      { song_code: 'smr-sounds'    , performer_codes: 'r-goulet'      , youtube_key: '1gGJ8AHYloQ' },
      { song_code: 'soft-love'     , performer_codes: 'della-reese'   , youtube_key: 'f4MXVgw_3hg' },
      { song_code: 'ssss-heart'    , performer_codes: 'ink-spots'     , youtube_key: 'z617AUVXyMs' },
      { song_code: 'stair-love'    , performer_codes: 'm-robbins'     , youtube_key: 'DxWBnm8Dbs0' },
      { song_code: 'stay-away'     , performer_codes: 'elvis'         , youtube_key: 'wr6MQtFLX6k' },
      { song_code: 'stop-think'    , performer_codes: 'p-como'        , youtube_key: 'PE6n4SHZspY' },
      { song_code: 'suzy-snow'     , performer_codes: 'r-clooney'     , youtube_key: 'UiFXZhU5kp4' },
      { song_code: 't-t-fingers'   , performer_codes: 'naysayer'      , youtube_key: '8tdJg3oB5DM' },
      { song_code: 't-t-fingers'   , performer_codes: 'stargazers'    , youtube_key: 'K0ozZZ_RhP8' },
      { song_code: 'take-me-fair'  , performer_codes: 'elvis'         , youtube_key: 'DaOGCwGkdCE' },
      { song_code: 'tear-rain'     , performer_codes: 'a-prysock'     , youtube_key: '7xVk2GY-TOI' },
      { song_code: 'tr-light'      , performer_codes: 'h-hermits'     , youtube_key: 'stDqoS3zeTE' },
      { song_code: 'train-ahchoo'  , performer_codes: 'anne-lloyd'    , youtube_key: 'S2PFb24d2Ak' },
      { song_code: 'vino'          , performer_codes: 'elvis'         , youtube_key: 'iRZcg4nXprY' },
      { song_code: 'walls-ears'    , performer_codes: 'elvis'         , youtube_key: '4dGrDNvSdNM' },
      { song_code: 'west-union'    , performer_codes: 'elvis'         , youtube_key: '-cs_R-QWqcA' },
      { song_code: 'wheels-heels'  , performer_codes: 'elvis'         , youtube_key: 'zxn5EWXpUOE' },
      { song_code: 'when-arms'     , performer_codes: 'c-francis'     , youtube_key: 'FudzowDyQn0' },
      { song_code: 'wond-world'    , performer_codes: 'elvis'         , youtube_key: '5GwapUKv5V4' },
      { song_code: 'woodchuck'     , performer_codes: 'ben-mill'      , youtube_key: '06BlIlEjhV8' },
      { song_code: 'ww-young'      , performer_codes: 'andy-wms'      , youtube_key: 'eoRVnPH8uUI' },
      { song_code: 'young-ones'    , performer_codes: 'clf-rich'      , youtube_key: 'BxNohANhJiA' },
  ]

  print "Adding #{plays.count} song plays..."

  plays.each do |play|
    song_code = play[:song_code]
    song = Song.find_by_code(song_code)
    performer_codes = Array(play[:performer_codes])
    performers = performer_codes.map { |code| Performer.find_by_code(code) }
    code = song_code + '.' + performer_codes.first

    begin
      SongPlay.create!(song: song, performers: performers, youtube_key: play[:youtube_key], code: code)
    rescue => e
      $stderr.puts "Error adding song play code ''#{code}''"
      raise
    end
  end

  puts 'done.'
end


def add_rights_admin_links
  warner_song_codes = %w{
    bye-boys
    crush-ny
    eggbert
    glad
    jenny-kiss
    kewpie-doll
    kiss-fire
    n-for-xmas
    nty-lady
    red-roses
    run-back-me
    suzy-snow
    tear-rain
    tr-light
    when-arms
    ww-young
    young-ones
  }

  puts warner_song_codes.select { |code| Song.find_by_code(code).nil? }
  warner_songs = warner_song_codes.map { |code| Song.find_by_code(code) }
  warner = Organization.find_by_code('warner')
  warner_songs.each { |song| song.rights_admin_orgs << warner }
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



