class AddOrientationToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :orientation, :int, :default => 0
  end

  def self.down
    remove_column :images, :orientation
  end
end
