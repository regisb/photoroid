class CreatePasswordReminders < ActiveRecord::Migration
  def self.up
    create_table :password_reminders do |t|
      t.integer :user_id
      t.string :secret

      t.timestamps
    end
  end

  def self.down
    drop_table :password_reminders
  end
end
