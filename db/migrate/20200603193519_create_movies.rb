class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :code
      t.string :name
      t.integer :year
      t.text :notes

      t.timestamps
    end
    add_index :movies, :code
    add_index :movies, :name
    add_index :movies, :year
  end
end
