class GamesController < ApplicationController

  layout 'test_layout'

  # def index #GET
  #   self.list
  # end
  #
  # def list #GET
  #   @game = Game.all
  # end
  #
  # def status #GET
  #   game_id = params[:game_id] rescue nil
  #   redirect_to 'list' if game_id == nil #me thinks this is pseudo code
  #   @game = Game.find(game_id)
  # end

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
    @game = Game.new({:server_id => '14'})
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = "Game created successfully."
      redirect_to('/games/admin')
    else
      render('new')
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:server_id, :friendly_name, :service_name)
  end
end
