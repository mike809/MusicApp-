class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :band_id, :null => false
      t.string :type_of_album
      
      t.timestamps
    end
  end
end
