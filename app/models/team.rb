class Team < ApplicationRecord
	has_many :players
	has_many :match_teams
	has_many :matches, :through => :match_teams
	has_many :winning_matches, :class_name => 'Match', :foreign_key => 'winning_team_id', :dependent => :restrict_with_error
	has_many :winning_games, :class_name => 'Game', :foreign_key => 'winning_team_id', :dependent => :restrict_with_error
	has_many :game_scores
	has_many :games, :through => :game_scores
end
