class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id, :null => false
      t.string :title
      t.string :type_of_track
      t.text :lyrics
      
      t.timestamps
    end
  end
end
