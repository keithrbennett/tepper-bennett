class CreateGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :genres do |t|
      t.string :code
      t.string :name
      t.text :notes

      t.timestamps
    end
    add_index :genres, :code
    add_index :genres, :name
  end
end
