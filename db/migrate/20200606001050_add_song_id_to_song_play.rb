class AddSongIdToSongPlay < ActiveRecord::Migration[6.0]
  def change
    add_column :song_plays, :song_id, :integer
    add_index :song_plays, :song_id
    add_foreign_key :song_plays, :songs
  end
end
