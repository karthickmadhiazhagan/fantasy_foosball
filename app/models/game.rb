class Game < ApplicationRecord
  belongs_to :match
  has_many :game_scores, :dependent => :destroy
  has_many :teams, :through => :game_scores
  belongs_to :winning_team, :class_name => 'Team', optional: true
  accepts_nested_attributes_for :game_scores
end
