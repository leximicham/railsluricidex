class GamesController < ApplicationController

  layout 'admin_area'

  def admin
    @game = Game.all
  end

  def delete
    @game = Game.find(params[:id])
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:notice] = "Game '#{@game.friendly_name}' destroyed successfully."
    redirect_to('/games/admin')
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      flash[:notice] = "Game updated successfully."
      redirect_to('/games/admin')
    else
      render('new')
    end
  end

  def new
    @game = Game.new({:server_id => 'input the SERVER id'})
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = "Game created successfully."
      redirect_to('/games/admin')
    else
      flash[:error] = "Game failed to be created."
      render('new')
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:server_id, :friendly_name, :service_name, :port, :notes)
  end
end
