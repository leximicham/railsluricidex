class Api::V0::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to? :json

  def index #GET
    render json: Game.all
  end

  def show #GET
    game = Game.find(params[:id])
    render json: game, status: 200
  end

  def destroy #PATCH
    game = Game.find(params[:id])
    game.destroy
    render json: "Successfully destroyed", status: 204
  end

  def update #PUT
    game = Game.find(params[:id])
    game.update_attributes(game_params)
    render json: game, status: 200
  end

  def create #POST
    game = Game.new(game_params)
    game.save
    render json: game, status: 201
  end

  private

  def game_params
    params.permit(:server_id, :friendly_name, :service_name, :port, :notes)
  end
end
