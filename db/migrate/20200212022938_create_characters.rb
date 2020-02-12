class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.string :lore
      t.string :power
      t.integer :user_id
    end
  end
end
