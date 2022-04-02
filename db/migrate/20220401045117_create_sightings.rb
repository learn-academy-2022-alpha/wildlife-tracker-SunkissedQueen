class CreateSightings < ActiveRecord::Migration[7.0]
  def change
    create_table :sightings do |t|
      t.datetime :date
      t.string :latitude
      t.string :longitude
      t.integer :chicken_id

      t.timestamps
    end
  end
end
