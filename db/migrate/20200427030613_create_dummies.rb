class CreateDummies < ActiveRecord::Migration[6.0]
  def change
    create_table :dummies do |t|
      t.string :dummy

      t.timestamps
    end
  end
end
