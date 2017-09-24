require 'byebug'
require_relative './player'
class Game

  attr_reader :dictionary, :players
  attr_accessor :fragment

  def initialize(*players)
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @players = players
    @fragment = ""
  end

  def display_score
    @players.each do |player|
      puts "#{player.name} : #{player.letters}"
    end
  end

  def play_round
    until game_over?
      take_turn(current_player)
      self.restart if lost_round?
      next_player!
    end
    puts "#{current_player.name}. you won!"
  end

  def restart

    current_player.add_letter!
    @fragment = ""
    display_score
    sleep(2)
  end

  def lost_round?
    dictionary.include?(fragment)
  end

  def eliminated?
    players.letters == "GHOST"
  end

  def game_over?
    @players.reject{ |player| player.eliminated}.size == 1
  end



  def next_player!
    @players.rotate!
    @players.rotate! while current_player.eliminated

  end

  def current_player
    players[0]
  end

  def take_turn(player)
    char = nil
    until valid_play(char)
      system('clear')
      puts "#{current_player.name}, that's not a valid guess. Try again" if char != nil
      puts "#{current_player.name}, please enter a char, to add on to '#{fragment}'. do Not complete the word! "
      char = player.guess
    end
    @fragment += char
  end

  def valid_play(char)
    ('A'..'z').include?(char) &&  dictionary.any?{ |word| word.start_with?(fragment + char) }
  end



end

player1 = Player.new("fredrick")
player2 = Player.new("gimple")
Game.new(player1, player2).play_round
