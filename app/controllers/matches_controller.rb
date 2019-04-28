class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  include PlayersHelper
  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.includes(:winning_team).all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
    @games = @match.games
  end

  # GET /matches/new
  def new
    @match = Match.new
    #@match.match_teams.build(2) # = [MatchTeam.new(@match), MatchTeam.new(@match)]
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    home_team = params[:home_team]
    away_team = params[:away_team]
    @match = Match.new(match_params)
    respond_to do |format|
      if @match.save
        create_match_teams_games(home_team,away_team)
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # create games and match team deatils at the time of match creation
  def create_match_teams_games(home_team, away_team)
    MatchTeam.create(:team_id => home_team, :match_id => @match.id)
    MatchTeam.create(:team_id => away_team, :match_id => @match.id)
    # Creating 3 games
    (1 .. 3).each do |index|
      game = Game.create(:match_id => @match.id)
      GameScore.create(:team_id => home_team, :game_id => game.id)
      GameScore.create(:team_id => away_team, :game_id => game.id)
    end

  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:winning_team_id)
    end
end
