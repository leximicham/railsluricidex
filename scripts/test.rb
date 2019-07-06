#!/usr/bin/env ruby

require_relative '../config/environment'

puts Rails.env

def command #POST
	game_id = params[:game_id] rescue nil
	command = params[:command] rescue nil
	@game = Game.find(game_id)
	@game.send(command)
end
