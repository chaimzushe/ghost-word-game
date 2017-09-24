require 'byebug'
class Game

  attr_reader :dictionary, :current_player, :players
  attr_accessor :fragment
  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @players = []
    @fragment = ""
    @current_player = players[0]
  end

  def play_round
    until game_over?
      take_turn(current_player)
    end
    puts "i'm sorry. game over. #{fragment} is a real word"
  end

  def game_over?
    dictionary.include?(fragment)
  end

  def next_player!
    players.rotate!
  end

  def take_turn(player)
    char = nil
    until valid_play(char)

      if char != nil
        puts "Not a vlaid char"
      else
        system("clear")
        puts "please enter a valid char, to add on to '#{fragment}'. do Not complete the word! "
      end
      char = gets.chomp
    end
    @fragment += char
  end

  def valid_play(char)
    ('A'..'z').include?(char) &&  dictionary.any?{ |word| word.start_with?(fragment + char) }
  end

end


Game.new.play_round
