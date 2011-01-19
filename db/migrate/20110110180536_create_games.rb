class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|

      t.integer :row_letters
      t.text :letters

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end