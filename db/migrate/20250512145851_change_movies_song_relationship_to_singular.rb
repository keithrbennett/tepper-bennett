class ChangeMoviesSongRelationshipToSingular < ActiveRecord::Migration[8.0]
  def change
    # Add movie_id column to songs table
    add_column :songs, :movie_id, :integer
    add_index :songs, :movie_id
    
    # Create a temporary table to store song-movie associations
    create_table :temp_song_movie_associations, temporary: true do |t|
      t.integer :song_id
      t.integer :movie_id
    end
    
    # Copy data from the join table to the temporary table
    # We'll only keep the first movie for each song since we're changing to a singular relationship
    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO temp_song_movie_associations (song_id, movie_id)
          SELECT DISTINCT song_id, movie_id 
          FROM movies_songs
          WHERE (song_id, movie_id) IN (
            SELECT song_id, MIN(movie_id) 
            FROM movies_songs 
            GROUP BY song_id
          )
        SQL
        
        # Copy the associations to the new column
        execute <<-SQL
          UPDATE songs
          SET movie_id = (
            SELECT movie_id 
            FROM temp_song_movie_associations 
            WHERE temp_song_movie_associations.song_id = songs.id
          )
          WHERE id IN (SELECT song_id FROM temp_song_movie_associations)
        SQL
      end
    end
    
    # Drop the join table
    drop_table :movies_songs
  end
end
