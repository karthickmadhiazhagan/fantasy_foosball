json.extract! player, :id, :firstname, :lastname, :team_id, :created_at, :updated_at
json.url player_url(player, format: :json)
