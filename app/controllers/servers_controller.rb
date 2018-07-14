class ServersController < ApplicationController
  VALID_COMMANDS = ["call_start","call_stop"]
  def index #GET
    self.list
  end

  def list #GET
    @servers = Server.all
  end

  def status #GET
    server_id = params[:server_id] rescue nil
    redirect_to 'list' if server_id == nil #me thinks this is pseudo code
    @server = Server.find(server_id)
  end

  def command #POST
    game_id = params[:game_id] rescue nil
	  command = params[:command] rescue nil
	  @game = Game.find(game_id)
	  redirect_to "status/#{@game.server_id}" unless VALID_COMMANDS.include?(command)
	  @game.call(command)
	  redirect_to "status/#{@game.server_id}"
  end

  def delete
  end

  def edit
  end

  def new
  end

  def show
  end
end
