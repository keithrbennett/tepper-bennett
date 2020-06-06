class CreatePerformers < ActiveRecord::Migration[6.0]
  def change
    create_table :performers do |t|
      t.string :code
      t.string :name
      t.text :notes

      t.timestamps
    end
    add_index :performers, :code
    add_index :performers, :name
  end
end
