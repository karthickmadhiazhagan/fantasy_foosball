class Game < ApplicationRecord
  belongs_to :match
  has_many :game_scores, :dependent => :destroy
  has_many :teams, :through => :game_scores
  belongs_to :winning_team, :class_name => 'Team', optional: true
  accepts_nested_attributes_for :game_scores
  before_create :create_game_scores
  before_save :set_winning_team
  validate :validate_scores

  def create_game_scores
  	self.match.match_teams.each do |match_team|
		self.game_scores.build(:team_id => match_team.team_id, :score => 0)
	end
  end

  def validate_scores
  	max_score_team_ids = max_score_team
  	if max_score_team_ids.count > 1
  		errors.add(:base, 'Both teams should not have the maximum score')
  	end
  end

  def set_winning_team
  	self.winning_team_id = max_score_team.try(:first).try(:team_id)
  end

  def max_score_team
  	self.game_scores.select { |g_score| g_score.team_id if g_score.score == 5 }
  end
end
