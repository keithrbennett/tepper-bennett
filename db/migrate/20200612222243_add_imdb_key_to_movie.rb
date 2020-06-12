class AddImdbKeyToMovie < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :imdb_key, :string
  end
end
