class Player
  LOSSING_LETTERS = 'GHOST'
  attr_reader :name, :letters
  def initialize(name)
    @name = name
    @letters = ""
  end

  def guess
    char = gets.chomp
  end

  def add_letter!
    puts "sorry #{name} you hit a word.. letter added"
    @letters[@letters.size] = LOSSING_LETTERS[@letters.size]
  end

  def eliminated
    @letters == LOSSING_LETTERS
  end



end
