require 'byebug'
class Game
  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @players = []
    @fragmnet = ""
  end
end

p Game.new
