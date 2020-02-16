class Api::V0::ServersController < ApplicationController
  VALID_COMMANDS = ["call_start","call_stop"]
  skip_before_action :verify_authenticity_token
  respond_to? :json

  def index #GET
    render json: Server.all
  end

  def show #GET
    server = Server.find(params[:id])
    render json: server, status: 200
  end

  def command #POST
    server = Server.find(params[:id])
    game_id = params[:game_id] rescue nil
	  command = params[:command] rescue nil
	  game = Game.find(game_id)
	  game.send(command)
    if command == "call_start"
      sleep 3
      status = game.running?
      if status == true
        render json: "Server is starting", status: 200
      else
        render json: "Server failed to start", status:504
      end
    else
      render json: "Stop request has been processed", status: 200
    end
  end

  def destroy #PATCH
    server = Server.find(params[:id])
    server.destroy
    render json: "Successfully destroyed", status: 204
  end

  def update #PUT
    server = Server.find(params[:id])
    server.update_attributes(server_params)
    render json: server, status: 200
  end

  def create #POST
    server = Server.new(server_params)
    server.save
    render json: server, status: 201
  end

  private

  def server_params
    params.permit(:friendly_name, :ip, :username, :keyfile)
  end
end
