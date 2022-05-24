class Player
  attr_reader :name, :color_code, :color_english
  def initialize(name, color_code, color_english)
    @name = name
    @color_code = color_code
    @color_english = color_english
    puts "#{@name} will be #{color_code} #{@color_english}."
  end
end

class ConnectFour
  attr_reader :player_one, :player_two, :players
  def initialize(player_one = Player.new(ask_name(1), "\u{1f7e1}", "yellow"), player_two = Player.new(ask_name(2), "\u{1f534}", "red"))
    @player_one = player_one
    @player_two = player_two
    @players = [@player_one, @player_two]
  end

  def ask_name(num)
    puts "Enter name for player #{num}"
    gets.chomp
  end
  
  def play_game
    @player = @players.shift
    print_interface
    column = player_input
    @players.push(@player)
  end

  def player_turn
    puts ""
  end

  def player_input
    loop do
      user_input = gets.chomp
      verified_col = verify_input(user_input.to_i) if user_input.match?(/^[1-7]$/)
      return verified_col if verified_col

      puts "Invalid Input!"
    end
  end

  def verify_input(user_input)
    return user_input if user_input.between?(1,7)
  end
end

game = ConnectFour.new
# game.play_game