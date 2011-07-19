class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|

      t.string :img_file_name
      t.string :img_content_type
      t.integer :img_file_size
      t.datetime :img_updated_at
      t.datetime :taken_at
      t.string :author_name
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
