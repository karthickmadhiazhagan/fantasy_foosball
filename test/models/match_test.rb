require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  	test "should not save both team as same in a match" do
	  match = Match.new
	  match.match_team_attributes = {"0"=>{"team_id"=>"1"}, "1"=>{"team_id"=>"1"}
	  assert_not match.save
	end
end
