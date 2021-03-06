class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.text :word
      t.integer :game_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :words
  end
end
