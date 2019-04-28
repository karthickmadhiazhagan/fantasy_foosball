class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    get_team_rankings
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_team_rankings
    sql_str = " select am.team_id, (COALESCE(wm.winning_matches,0)/COALESCE(am.total_matches, 0) ) as winning_percentage, RANK () OVER (
       ORDER BY
       (COALESCE(wm.winning_matches,0)/COALESCE(am.total_matches, 0) ) desc
       ) as team_rank from 
       (select team_id, count(match_id) as total_matches from match_teams group by team_id) am
       left join 
       (select winning_team_id, count(id) as winning_matches from matches group by winning_team_id) wm
       on am.team_id = wm.winning_team_id"
    @team_ranks = Hash.new
    team_rank_data = Team.find_by_sql(sql_str)
    team_rank_data.each do |rank_data|
      @team_ranks[rank_data.team_id] = {'winning_percentage' => (rank_data.winning_percentage*100).round(2), 'team_rank' => rank_data.team_rank}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
