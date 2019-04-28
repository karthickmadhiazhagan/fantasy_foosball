class Match < ApplicationRecord
	has_many :match_teams, :dependent => :destroy
	has_many :teams, :through => :match_teams
	belongs_to :winning_team, :class_name => 'Team', optional: true
	accepts_nested_attributes_for :match_teams
	has_many :games, :dependent => :destroy

	def match_name
		team_names = self.teams.map { |t| t.name }
		team_names.join(' VS ')
	end
end
