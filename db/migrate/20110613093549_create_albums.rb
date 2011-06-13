class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|

      t.timestamps
      t.string :title
      t.integer :user_id
      t.string :secret
    end

    add_column :images, :album_id, :integer
  end

  def self.down
    drop_table :albums
    remove_column :images, :album_id
  end
end
