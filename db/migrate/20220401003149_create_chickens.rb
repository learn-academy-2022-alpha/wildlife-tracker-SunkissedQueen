class CreateChickens < ActiveRecord::Migration[7.0]
  def change
    create_table :chickens do |t|
      t.string :name
      t.string :origin
      t.string :feature

      t.timestamps
    end
  end
end
