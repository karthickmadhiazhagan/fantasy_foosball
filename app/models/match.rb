class Match < ApplicationRecord
	has_many :match_teams, :dependent => :destroy
	has_many :teams, :through => :match_teams
	belongs_to :winning_team, :class_name => 'Team', optional: true
end
