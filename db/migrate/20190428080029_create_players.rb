class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :firstname
      t.string :lastname
      t.references :team, foreign_key: true, :null => true, :default => nil

      t.timestamps
    end
  end
end
