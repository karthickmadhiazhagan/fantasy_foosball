class Player < ApplicationRecord
  belongs_to :team, optional: true
  validates_presence_of :lastname, :firstname
  validate :check_team_availability

  def check_team_availability
  	if self.team.players.count > 1
  		errors.add(:base, 'Selected team already have 2 players')
  	end
  end
end
