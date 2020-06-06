class CreateJoinTables < ActiveRecord::Migration[6.0]
  def change
    create_join_table :songs, :genres
    create_join_table :songs, :movies
    create_join_table :songs, :organizations
    create_join_table :songs, :writers
    create_join_table :songs, :performers
    create_join_table :performers, :song_plays
  end
end
