class CreateGameScores < ActiveRecord::Migration[5.2]
  def change
    create_table :game_scores do |t|
      t.references :team, foreign_key: true
      t.references :game, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
