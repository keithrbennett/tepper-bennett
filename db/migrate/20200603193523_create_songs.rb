class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :code
      t.string :name
      t.text :notes

      t.timestamps
    end
    add_index :songs, :code
    add_index :songs, :name
  end
end
