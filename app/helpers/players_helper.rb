module PlayersHelper

	def team_array		
		team_arr = Array.new
		teams = Team.order(:id) 
		unless teams.blank?
			teams.each do | team |
				team_arr << [team.name, team.id]
			end
		end
		team_arr
	end
end
