class CreateSongPlays < ActiveRecord::Migration[6.0]
  def change
    create_table :song_plays do |t|
      t.string :code
      t.string :youtube_key
      t.string :url
      t.text :notes

      t.timestamps
    end
    add_index :song_plays, :code
    add_index :song_plays, :youtube_key
    add_index :song_plays, :url
  end
end
