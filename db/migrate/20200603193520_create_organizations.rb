class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :code
      t.string :name
      t.text :notes

      t.timestamps
    end
    add_index :organizations, :code
    add_index :organizations, :name
  end
end
