class Player < ApplicationRecord
  belongs_to :team, optional: true
  validates_presence_of :lastname, :firstname
  validate :check_team_availability, if: :team_id?

  def check_team_availability
  	if self.try(:team).try(:players).try(:count).to_i > 1
  		errors.add(:base, 'Selected team already have 2 players')
  	end
  end
end
