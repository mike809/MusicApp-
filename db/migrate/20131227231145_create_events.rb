class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :location
      t.integer :minimum_age
      t.blob :poster
      t.integer :rate
      t.date :date

      t.timestamps
    end
  end
end
