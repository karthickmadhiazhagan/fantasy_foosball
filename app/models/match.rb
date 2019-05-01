class Match < ApplicationRecord
	has_many :match_teams, :dependent => :destroy
	has_many :teams, :through => :match_teams
	belongs_to :winning_team, :class_name => 'Team', optional: true
	has_many :games, :dependent => :destroy
	accepts_nested_attributes_for :match_teams
	accepts_nested_attributes_for :games
	before_create :create_init_game
  	before_save :set_winning_team
 
  	def match_name
		team_names = self.teams.map { |t| t.name }
		team_names.join(' VS ')
	end

	def create_init_game
    	(1 .. 3).each {self.games.build}
  	end

  	def set_winning_team
  		self.winning_team_id = max_game_winner.try(:keys).try(:first)
  	end

  	def max_game_winner
  		team_wins = self.games.group(:winning_team_id).count
	  	winner = team_wins.select { |team, wins| team if wins > 1 }
	  	winner
	end
end
