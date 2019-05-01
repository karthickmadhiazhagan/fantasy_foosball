require 'test_helper'

class GameScoreTest < ActiveSupport::TestCase
  test "score should not be greater than 5" do
	  g_score = GameScore.new(:team_id =>1, :game_id => 1, :score => 6)
	  assert_not g_score.save
  end
end
