class Api::V0::ServersController < ApplicationController

  #This is the servers controller (API version) and can list servers and their associated games as well as edit the server information and make calls to these servers. Calls outlined below
  #For more info on games specific info and actions, check out games_controller.rb
  #This controller interacts with no views (API only) and touches the server and game db through their associated models
  #I'm keeping some test API calls in the Test API postman collection

  #Currently this controller can only handle 4 types of commands to the game servers.
  #-call_start - provided a valid game_id this tells the game and server models to call the SSH class in lib/ssh.rb to ssh into the Games server and use runit to start the relevant game server
  #-call_stop - provided a valid game_id this tells the game and server models to call the SSH class in lib/ssh.rb to ssh into the Games server and use runit to stop the relevant game server
  #-call_save - provided a valid game_id this tells the game and server models to call the ActLocally class in lib/local_commands.rb to send a preformatted rcon command with scripts/rcon
  #-get_last_saved_at - provided a valid game_id this tells the game and server models to call the ActLocally class in lib/local_commands.rb to run File.mtime on the game's .ark save on the nas

  VALID_COMMANDS = ["call_start","call_stop","call_save","get_last_saved_at"]

  #I don't know what this does

  skip_before_action :verify_authenticity_token

  #This seems like a best practice thing to tell the API controller to accept json but I'm not sure if it's necessary

  respond_to? :json

  #Below are the actions you can take on this controller (via the API).

  #GET - https://luricidex.com/api/v0/servers

  def index #GET
    render json: Server.all
  end

  def show #GET
    server = Server.find(params[:id])
    render json: server, status: 200
  end

  #POST - https://luricidex.com/api/v0/servers/command?id=6&game_id=14&command=call_save

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
    elsif command == "call_stop"
      sleep 20
      status = game.running?
      if status == false
        render json: "Server is stopped", status: 200
      else
        render json: "Server failed to stop", status:504
      end
    elsif command == "call_save"
      sleep 25
      updated = game.get_last_saved_at
      if updated == "Multiple saves found, something is probably wrong."
        render json: "Multiple saves found, something is probably wrong.", status: 500
      elsif updated != nil
        render json: "This map was last updated at #{updated}", status: 200
      else
        render json: "Something went wrong getting the updated time of this map", status:500
      end
    elsif command == "get_last_saved_at"
      updated = game.get_last_saved_at
      if updated == "Multiple saves found, something is probably wrong."
        render json: "Multiple saves found, something is probably wrong.", status: 500
      elsif updated != nil
        render json: "This map was last updated at #{updated}", status: 200
      else
        render json: "Something went wrong getting the updated time of this map", status:500
      end
    else
      render json: "There was an error with your request", status: 400
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

  #These are the only params allowed when sending an API request to the controller

  def server_params
    params.permit(:friendly_name, :ip, :username, :keyfile)
  end
end
