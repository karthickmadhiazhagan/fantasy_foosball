class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :match, foreign_key: true
      t.integer :winning_team_id

      t.timestamps
    end
  end
end
