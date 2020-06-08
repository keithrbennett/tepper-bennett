
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
      { code:  'lov_you',    year: 1957, name: "Loving You" },
      { code:  'k-creole',   year: 1958, name: "King Creole" },
      { code:  'flam-star',  year: 1960, name: "Flaming Star" },
      { code:  'gi-blues',   year: 1960, name: "G. I. Blues" },
      { code:  'b-hawaii',   year: 1961, name: "Blue Hawaii" },
      { code:  'foll-dream', year: 1962, name: "Follow That Dream" },
      { code:  'girls',      year: 1962, name: "Girls! Girls! Girls!" },
      { code:  'young-ones', year: 1962, name: "The Young Ones" },
      { code:  'acapulco',   year: 1963, name: "Fun in Acapulco" },
      { code:  'w-fair',     year: 1963, name: "It Happened at the World's Fair" },
      { code:  'g-happy',    year: 1964, name: "Girl Happy" },
      { code:  'k-cousins',  year: 1964, name: "Kissin' Cousins" },
      { code:  'roust',      year: 1964, name: "Roustabout" },
      { code:  'vegas',      year: 1964, name: "Viva Las Vegas" },
      { code:  'h-scarum',   year: 1965, name: "Harum Scarum" },
      { code:  'f-johnny',   year: 1966, name: "Frankie and Johnny" },
      { code:  'paradise',   year: 1966, name: "Paradise, Hawaiian Style" },
      { code:  'spinout',    year: 1966, name: "Spinout" },
      { code:  'clambake',   year: 1967, name: "Clambake" },
      { code:  'd-trouble',  year: 1967, name: "Double Trouble" },
      { code:  'speedway',   year: 1968, name: "Speedway" },
      { code:  's-a-joe',    year: 1968, name: "Stay Away, Joe" },
  ]
  print "Adding #{movies.size} movies..."
  movies.each { |m| Movie.create!(code: m[:code], year: m[:year], name: m[:name]) }
  puts 'done.'
end


def add_performers
  performers = [
      { code: "a-mooney"      , name: "Art Mooney & His Orchestra" },
      { code: "a-prysock"     , name: "Arthur Prysock" },
      { code: "ames-bros"     , name: "The Ames Brothers" },
      { code: "andy-wms"      , name: "Andy Williams" },
      { code: "anne-lloyd"    , name: "Anne Lloyd, Sandpiper Singers, Mitch Miller & Orchestra" },
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
      { code: "h-hermits"     , name: "Herman's Hermits" },
      { code: "homer-jethro"  , name: "Homer and Jethro" },
      { code: "ink-spots"     , name: "The Ink Spots" },
      { code: "jay-amer"      , name: "Jay and the Americans" },
      { code: "jeff-beck"     , name: "Jeff Beck" },
      { code: "kilburn"       , name: "Kilburn and the High Roads" },
      { code: "louis-arm"     , name: "Louis Armstrong" },
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
      { code: "ascap"         , name: "ASCAP" },
      { code: "bmi"           , name: "BMI" },
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


def add_song(code:, name:, performers: [], genres: [], writers: default_writers)
  db_song = Song.new(code: code, name: name, writers: writers)

  performers ||= []
  performers.each do |code|
    performer = Performer.find_by_code(code)
    raise "Performer for code '#{code}' not found." if performer.nil?
    db_song.performers << performer
  end

  genres ||= []
  genres.each do |code|
    genre = Genre.find_by_code(code)
    raise "Genre for code '#{code}' not found." if genre.nil?
    db_song.genres << genre
  end

  db_song.save!
end


def add_elvis_songs
  songs = [
      { code: "boy-like-me"   , name: "A Boy Like Me, A Girl Like You" },
      { code: "cane-collar"   , name: "A Cane and A High Starched Collar" },
      { code: "h-everything"  , name: "A House That Has Everything",  genres: %w{romantic} },
      { code: "all-i-am"      , name: "All That I Am", genres: %w{romantic} },
      { code: "am-i-ready"    , name: "Am I Ready", genres: %w{romantic} },
      { code: "angel"         , name: "Angel", genres: %w{romantic} },
      { code: "b-b-blues"     , name: "Beach Boy Blues" },
      { code: "beg-luck"      , name: "Beginners Luck", genres: %w{romantic} },
      { code: "confidence"    , name: "Confidence" },
      { code: "drums-isles"   , name: "Drums of the Islands" },
      { code: "earth-boy"     , name: "Earth Boy" },
      { code: "five-heads"    , name: "Five Sleepy Heads" },
      { code: "millionth"     , name: "For the Millionth and Last Time" },
      { code: "ft-laud"       , name: "Fort Lauderdale Chamber of Commerce" },
      { code: "g-i-blues"     , name: "G. I. Blues" },
      { code: "h-sunset"      , name: "Hawaiian Sunset" },
      { code: "one-girl"      , name: "I Love Only One Girl" },
      { code: "isl-love"      , name: "Island of Love", genres: %w{romantic} },
      { code: "wond-world"    , name: "It's a Wonderful World" },
      { code: "ito-eats"      , name: "Ito Eats" },
      { code: "old-sake"      , name: "Just for Old Time Sake" },
      { code: "kismet"        , name: "Kismet" },
      { code: "l-cowboy"      , name: "Lonesome Cowboy" },
      { code: "mexico"        , name: "Mexico" },
      { code: "mine"          , name: "Mine" },
      { code: "n-orleans"     , name: "New Orleans" },
      { code: "once-enough"   , name: "Once is Enough" },
      { code: "petunia"       , name: "Petunia, the Gardener's Daughter", genres: %w{romantic} },
      { code: "puppet"        , name: "Puppet on a String", genres: %w{romantic} },
      { code: "relax"         , name: "Relax" },
      { code: "shop-arnd"     , name: "Shoppin' Around" },
      { code: "sl-sand"       , name: "Slicin' Sand" },
      { code: "smorgasbord"   , name: "Smorgasbord" },
      { code: "shrimp"        , name: "Song of the Shrimp" },
      { code: "stay-away"     , name: "Stay Away" },
      { code: "take-me-fair"  , name: "Take Me to the Fair" },
      { code: "bullfighter"   , name: "The Bullfighter Was a Lady", genres: %w{romantic} },
      { code: "lady-loves"    , name: "The Lady Loves Me", genres: %w{romantic} },
      { code: "walls-ears"    , name: "The Walls Have Ears" },
      { code: "vino"          , name: "Vino, Dinero y Amor" },
      { code: "west-union"    , name: "Western Union" },
      { code: "wheels-heels"  , name: "Wheels on My Heels" },
  ]

  puts "Song codes too long: #{songs.map { |h| h[:code] }.select { |code| code.length > 12 }}"
  print "Adding #{songs.size} Elvis songs..."

  songs.each do |s|
    add_song(code: s[:code], name: s[:name], performers: ['elvis'], genres: s[:genres])
  end
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
      { code: "kiss-fire"     , name: "Kiss of Fire" ,                             performers: %w(louis-arm),   genres: %w{romantic} },
      { code: "n-for-xmas"    , name: "Nuttin' for Christmas" ,                    performers: %w(b-gordon),    genres: %w{children} },
      { code: "red-roses"     , name: "Red Roses for a Blue Lady" ,                performers: %w(andy-wms bert-kmft dean-martin p-como r-conniff sinatra v-monroe w-newton), genres: %w{romantic} },
      { code: "santa-daddy"   , name: "Santa Claus Looks Just Like Daddy" ,        performers: %w(b-gordon),    genres: %w{children} },
      { code: "ssss-heart"    , name: "Say Something Sweet to Your Sweetheart" ,   performers: %w(ink-spots),   genres: %w{romantic} },
      { code: "soft-love"     , name: "Softly My Love" ,                           performers: %w(della-reese), genres: %w{romantic} },
      { code: "smr-sounds"    , name: "Summer Sounds" ,                            performers: %w(r-goulet) },
      { code: "suzy-snow"     , name: "Suzy Snowflake" ,                           performers: %w(r-clooney),   genres: %w{children} },
      { code: "tear-rain"     , name: "Teardrops in the Rain" ,                    performers: %w(a-prysock),   genres: %w{romantic} },
      { code: "train-ahchoo"  , name: "The Little Train Who Said 'Ah Choo" ,       performers: %w(anne-lloyd),  genres: %w{children} },
      { code: "nty-lady"      , name: "The Naughty Lady of Shady Lane" ,           performers: %w(ames-bros),   genres: %w{funny} },
      { code: "woodchuck"     , name: "The Woodchuck Song" ,                       performers: %w(ben-mill) },
      { code: "yng-ones"      , name: "The Young Ones" ,                           performers: %w(clf-rich),    genres: %w{tv movie} },
      { code: "tr-light"      , name: "Travelling Light" ,                         performers: %w(clf-rich jay-amer) },
      { code: "t-t-fingers"   , name: "Twenty Tiny Fingers" ,                      performers: %w(stargazers),  genres: %w{children} },
      { code: "when-arms"     , name: "When the Boy (Girl) in Your Arms" ,         performers: %w(c-francis),   genres: %w{romantic} },
      { code: "ww-young"      , name: "Wonderful World of the Young" ,             performers: %w(andy-wms clf-rich) },
  ]

  print "Adding #{songs.count} non-Elvis songs..."
  songs.each do |s|
    add_song(code: s[:code], name: s[:name], performers: s[:performers], genres: s[:genres])
  end
  puts 'done.'
end

def add_song_plays

  plays = [
      { song_code: 'all-i-am'      , performer_code: 'elvis'         , youtube_key: 'ireqvLFf08A' },
      { song_code: 'am-i-ready'    , performer_code: 'elvis'         , youtube_key: 'E2J13o-RsxA' },
      { song_code: 'angel'         , performer_code: 'elvis'         , youtube_key: '7RQuoPVMPT0' },
      { song_code: 'b-b-blues'     , performer_code: 'elvis'         , youtube_key: 'Oq8BI8wB8Fk' },
      { song_code: 'bagel-lox'     , performer_code: 'rob-schneid'   , youtube_key: 'dv4h8yU_N7o' },
      { song_code: 'beg-luck'      , performer_code: 'elvis'         , youtube_key: '0IGp5zqeLLk' },
      { song_code: 'boy-like-me'   , performer_code: 'elvis'         , youtube_key: 'cPQ5nnwYA2Q' },
      { song_code: 'bullfighter'   , performer_code: 'elvis'         , youtube_key: 'kHTX0kU3sEo' },
      { song_code: 'bye-boys'      , performer_code: 'jay-amer'      , youtube_key: 'BWyneW_A4_8' },
      { song_code: 'cane-collar'   , performer_code: 'elvis'         , youtube_key: 'AE78rPjs6Mo' },
      { song_code: 'confidence'    , performer_code: 'elvis'         , youtube_key: 'DE9Mc9cnBkg' },
      { song_code: 'crush-ny'      , performer_code: 'c-francis'     , youtube_key: '0_Gycn0UJ9M' },
      { song_code: 'drums-isles'   , performer_code: 'elvis'         , youtube_key: '4pXqiV-gbEk' },
      { song_code: 'earth-boy'     , performer_code: 'elvis'         , youtube_key: 'h_i4Dmfowjs' },
      { song_code: 'eggbert'       , performer_code: 'r-clooney'     , youtube_key: 'xkLGm9B60oY' },
      { song_code: 'five-heads'    , performer_code: 'elvis'         , youtube_key: 'tZK2FcTjBsE' },
      { song_code: 'ft-laud'       , performer_code: 'elvis'         , youtube_key: '3In-gZ5IL7s' },
      { song_code: 'g-i-blues'     , performer_code: 'elvis'         , youtube_key: 'GkyjCJvHLsA' },
      { song_code: 'glad'          , performer_code: 'beatles'       , youtube_key: 'ghag_1WCEuQ' },
      { song_code: 'glad'          , performer_code: 'jeff-beck'     , youtube_key: 'OP0JNb6jfqU' },
      { song_code: 'h-everything'  , performer_code: 'elvis'         , youtube_key: 'oh2wVSAnv98' },
      { song_code: 'h-sunset'      , performer_code: 'elvis'         , youtube_key: 'ggjntl7S7oA' },
      { song_code: 'isl-love'      , performer_code: 'elvis'         , youtube_key: '6RilIva9usA' },
      { song_code: 'ito-eats'      , performer_code: 'elvis'         , youtube_key: 's1jb7o8GlrQ' },
      { song_code: 'jenny-kiss'    , performer_code: 'ed-albert'     , youtube_key: '/Vf-9-rNHjcE' },
      { song_code: 'kewpie-doll'   , performer_code: 'p-como'        , youtube_key: 'YJ9W47TIRR4' },
      { song_code: 'kismet'        , performer_code: 'elvis'         , youtube_key: 'fnqC2I9QpIU' },
      { song_code: 'kiss-fire'     , performer_code: 'louis-arm'     , youtube_key: 'gVxwN3Eaf_U' },
      { song_code: 'l-cowboy'      , performer_code: 'elvis'         , youtube_key: 'DxComjngP2Q' },
      { song_code: 'lady-loves'    , performer_code: 'elvis'         , youtube_key: 'Fv0bpfGfzls' },
      { song_code: 'long-way'      , performer_code: 'sinatra'       , youtube_key: '7-tcw6w4Cj4' },
      { song_code: 'mexico'        , performer_code: 'elvis'         , youtube_key: 'eCQrdpoBass' },
      { song_code: 'millionth'     , performer_code: 'elvis'         , youtube_key: '0hhN13Qzl-Q' },
      { song_code: 'mine'          , performer_code: 'elvis'         , youtube_key: 'GVMaaTaucsQ' },
      { song_code: 'n-for-xmas'    , performer_code: 'b-gordon'      , youtube_key: '9J-hyQGmhlo' },
      { song_code: 'n-for-xmas'    , performer_code: 'sugarland'     , youtube_key: 'VTjUZlLdmu8' },
      { song_code: 'n-orleans'     , performer_code: 'elvis'         , youtube_key: 'A9C-oQ_mFSc' },
      { song_code: 'nty-lady'      , performer_code: 'ames-bros'     , youtube_key: '9HxB7lxbTnI' },
      { song_code: 'old-sake'      , performer_code: 'elvis'         , youtube_key: 'hyQSTzn58b0' },
      { song_code: 'once-enough'   , performer_code: 'elvis'         , youtube_key: 'vxhe3_dTaBM' },
      { song_code: 'one-girl'      , performer_code: 'elvis'         , youtube_key: 'ito_RR2kwS0' },
      { song_code: 'petunia'       , performer_code: 'elvis'         , youtube_key: 'wuzbUsy6snc' },
      { song_code: 'petunia'       , performer_code: 'elvis'         , youtube_key: 'wuzbUsy6snc' },
      { song_code: 'puppet'        , performer_code: 'elvis'         , youtube_key: 'RjWoFTu0W28' },
      { song_code: 'red-roses'     , performer_code: 'moscow-jazz'   , youtube_key: '8-kRyR9c0uc' },
      { song_code: 'red-roses'     , performer_code: 'sinatra'       , youtube_key: 'hu5qvkiQVjE' },
      { song_code: 'red-roses'     , performer_code: 'w-newton'      , youtube_key: 'HssRO5b_ED0' },
      { song_code: 'relax'         , performer_code: 'elvis'         , youtube_key: 'DDH5xsR2b6g' },
      { song_code: 'run-back-me'   , performer_code: 'n-wilson'      , youtube_key: 'QlzCpTEhhQM' },
      { song_code: 'santa-daddy'   , performer_code: 'b-gordon'      , youtube_key: '0JCXmuNnrNc' },
      { song_code: 'shop-arnd'     , performer_code: 'elvis'         , youtube_key: 'ADjm8yzYFW4' },
      { song_code: 'shrimp'        , performer_code: 'elvis'         , youtube_key: '_GEKrj_ZloI' },
      { song_code: 'sl-sand'       , performer_code: 'elvis'         , youtube_key: 'ri3oqaZqAjo' },
      { song_code: 'smorgasbord'   , performer_code: 'elvis'         , youtube_key: 'PzGLzYnSNes' },
      { song_code: 'smr-sounds'    , performer_code: 'r-goulet'      , youtube_key: '1gGJ8AHYloQ' },
      { song_code: 'soft-love'     , performer_code: 'della-reese'   , youtube_key: 'f4MXVgw_3hg' },
      { song_code: 'ssss-heart'    , performer_code: 'ink-spots'     , youtube_key: 'z617AUVXyMs' },
      { song_code: 'stay-away'     , performer_code: 'elvis'         , youtube_key: 'wr6MQtFLX6k' },
      { song_code: 'suzy-snow'     , performer_code: 'r-clooney'     , youtube_key: 'UiFXZhU5kp4' },
      { song_code: 't-t-fingers'   , performer_code: 'stargazers'    , youtube_key: 'K0ozZZ_RhP8' },
      { song_code: 't-t-fingers'   , performer_code: 'stargazers'    , youtube_key: 'K0ozZZ_RhP8' },
      { song_code: 'take-me-fair'  , performer_code: 'elvis'         , youtube_key: 'DaOGCwGkdCE' },
      { song_code: 'tear-rain'     , performer_code: 'a-prysock'     , youtube_key: '7xVk2GY-TOI' },
      { song_code: 'tr-light'      , performer_code: 'h-hermits'     , youtube_key: 'stDqoS3zeTE' },
      { song_code: 'train-ahchoo'  , performer_code: 'anne-lloyd'    , youtube_key: 'S2PFb24d2Ak' },
      { song_code: 'vino'          , performer_code: 'elvis'         , youtube_key: 'iRZcg4nXprY' },
      { song_code: 'walls-ears'    , performer_code: 'elvis'         , youtube_key: '4dGrDNvSdNM' },
      { song_code: 'west-union'    , performer_code: 'elvis'         , youtube_key: '-cs_R-QWqcA' },
      { song_code: 'wheels-heels'  , performer_code: 'elvis'         , youtube_key: 'zxn5EWXpUOE' },
      { song_code: 'when-arms'     , performer_code: 'c-francis'     , youtube_key: 'FudzowDyQn0' },
      { song_code: 'wond-world'    , performer_code: 'elvis'         , youtube_key: '5GwapUKv5V4' },
      { song_code: 'woodchuck'     , performer_code: 'ben-mill'      , youtube_key: '06BlIlEjhV8' },
      { song_code: 'ww-young'      , performer_code: 'andy-wms'      , youtube_key: 'eoRVnPH8uUI' },
      { song_code: 'yng-ones'      , performer_code: 'clf-rich'      , youtube_key: 'BxNohANhJiA' },
  ]

  print "Adding #{plays.count} song plays..."

  plays.each do |play|
    song = Song.find_by_code(play[:song_code])
    performer = Performer.find_by_code(play[:performer_code])
    raise "Performer whose code is #{play[:performer_code]} not found." if performer.nil?
    youtube_key = play[:youtube_key]
    SongPlay.create!(song: song, performers: [performer], youtube_key: youtube_key)
  end

  puts 'done.'
end


def add_song_genres
  elvis_genre = Genre.find_by_code('elvis')
  movie_genre = Genre.find_by_code('movie')
  Song.all.select { |song| song.performer_codes.include?('elvis') }.each do |song|
    song.genres << elvis_genre
    song.genres << movie_genre
  end
end


add_genres
add_writers
add_movies
add_performers
add_organizations
add_elvis_songs
add_non_elvis_songs
add_song_plays
add_song_genres