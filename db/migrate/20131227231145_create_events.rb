class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :location
      t.integer :minimum_age
      t.integer :ratio
      t.binary :poster
      t.integer :rate
      t.date :date

      t.timestamps
    end
  end
end
