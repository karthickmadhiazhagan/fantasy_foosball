require 'test_helper'

class PlayerTest < ActiveSupport::TestCase  
	test "should not save player without firstname and lastname" do
	  player = Player.new
	  assert_not player.save
	  player.firstname = 'Karthick'
	  assert_not player.save
	end

	test "should save player without team" do
	  player = Player.new(:firstname => 'Rabada', :lastname => 'Chrish')
	  assert player.save
	end

	test "should save player to the team having less than 2 players" do
		player = Player.new(:firstname => 'Jack', :lastname => 'Kalish', :team_id => 1)
	  	assert player.save
	end

	test "should not save player to the team having already 2 players" do
		player = Player.new(:firstname => 'AB', :lastname => 'Deviliers', :team_id => 1)
	  	assert_not player.save
	end
end
