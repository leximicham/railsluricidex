class ServersController < ApplicationController
  VALID_COMMANDS = ["call_start","call_stop","call_save"]

  layout 'admin_area'

  def index #GET
    @server = Server.all
  end

  def admin
    @server = Server.all
  end

  def command #POST
    game_id = params[:game_id] rescue nil
	  command = params[:command] rescue nil
	  @game = Game.find(game_id)
	  redirect_to('/servers') unless VALID_COMMANDS.include?(command)
	  @game.send(command)
    if command == "call_start"
      sleep 3
      redirect_to('/servers')
    elsif command == "call_stop"
      sleep 20
      redirect_to('/servers')
    elsif command == "call_save"
      sleep 15
      redirect_to('/servers')
    else
	    redirect_to('/servers')
    end
  end

  def delete
    @server = Server.find(params[:id])
  end

  def destroy
    @server = Server.find(params[:id])
    @server.destroy
    flash[:notice] = "Server '#{@server.friendly_name}' destroyed successfully."
    redirect_to('/servers/admin')
  end

  def edit
    @server = Server.find(params[:id])
  end

  def update
    @server = Server.find(params[:id])
    if @server.update_attributes(server_params)
      flash[:notice] = "Server updated successfully."
      redirect_to('/servers/admin')
    else
      render('new')
    end
  end

  def new
    @server = Server.new({:keyfile => '"/home/Web/.ssh/id_rsa"'})
  end

  def create
    @server = Server.new(server_params)
    if @server.save
      flash[:notice] = "Server created successfully."
      redirect_to('/servers/admin')
    else
      flash[:error] = "Server failed to be created."
      render('new')
    end
  end

  def show
    @server = Server.find(params[:id])
  end

  private

  def server_params
    params.require(:server).permit(:friendly_name, :ip, :username, :keyfile)
  end
end
