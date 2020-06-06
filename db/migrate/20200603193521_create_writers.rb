class CreateWriters < ActiveRecord::Migration[6.0]
  def change
    create_table :writers do |t|
      t.string :code
      t.string :name
      t.text :notes

      t.timestamps
    end
    add_index :writers, :code
    add_index :writers, :name
  end
end
