require_relative '../lib/game'
require 'bundler/inline'

gemfile true do
 source 'http://rubygems.org'
 gem 'colorize'
end

game = ConnectFour.new
game.play_game