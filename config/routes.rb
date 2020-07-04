Rails.application.routes.draw do
  root to: 'home#index'

  get 'home' => 'home#index'
  get 'genres' => 'genres#index'
  get 'resources' => 'resources#index'
  get 'songs' => 'songs#index'
  get 'elvis' => 'elvis#index'

  get 'reports' => 'reports#index'

  get 'reports/songs' => 'reports#songs'
  get 'reports/performers' => 'reports#performers'
  get 'reports/song_plays' => 'reports#song_plays'
  get 'reports/genres' => 'reports#genres'
  get 'reports/song_performers' => 'reports#song_performers'
  get 'reports/performer_songs' => 'reports#performer_songs'
  get 'reports/song_genres' => 'reports#song_genres'
  get 'reports/genre_songs' => 'reports#genre_songs'
  get 'reports/movies' => 'reports#movies'
  get 'reports/movie_songs' => 'reports#movie_songs'
  get 'reports/organizations' => 'reports#organizations'
  get 'reports/rights_admins' => 'reports#rights_admins'
  get 'reports/writers' => 'reports#writers'

  # get 'reports/:rpt_type' => "reports#:rpt_type"

  get 'inquiries' => 'inquiries#index'

end
