class ServersController < ApplicationController
  VALID_COMMANDS = ["call_start","call_stop"]

  layout 'test_layout'

  def index #GET
    self.list
  end

  def list #GET
    @server = Server.all
    # byebug
  end

  def status #GET
    server_id = params[:server_id] rescue nil
    redirect_to 'list' if server_id == nil #me thinks this is pseudo code
    @server = Server.find(server_id)
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
	  redirect_to('/servers')
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
    @server = Server.new({:keyfile => '~/.ssh/id_rsa'})
  end

  def create
    @server = Server.new(server_params)
    if @server.save
      flash[:notice] = "Server created successfully."
      redirect_to('/servers/admin')
    else
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
