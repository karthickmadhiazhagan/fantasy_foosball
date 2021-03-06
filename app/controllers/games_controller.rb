class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update]
  def index
  	@games = Games.all
  end

  def edit
  end

  def show
  end

  def update
  	respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game.match, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:winning_team_id, :game_scores_attributes => [:id,:score, :team_id])
    end
end
