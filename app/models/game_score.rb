class GameScore < ApplicationRecord
  belongs_to :team
  belongs_to :game
  validates :score, :inclusion => 0..5, allow_nil: true
end
