require 'colorize'
require 'pry-byebug'

class Player
  attr_reader :name, :color_english
  def initialize(name, color_english)
    @name = name
    @color_english = color_english
    color_code = if @color_english == "Y"
      "\u{25CF} ".yellow
    else
      "\u{25CF} ".red
    end
    # puts "#{@name} will be #{color_code}#{@color_english}."
  end
end

class ConnectFour
  attr_reader :player_one, :player_two, :players, :board
  def initialize(player_one = Player.new(ask_name(1), "Y"), player_two = Player.new(ask_name(2), "R"), board = Array.new(6) { Array.new(7,0) })
    @player_one = player_one
    @player_two = player_two
    @players = [@player_one, @player_two]
    @board = board
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

  def full_col?(col)
    if @board[5][col].eql?(0)
      true
    else
      false
    end
  end

  def show_interface
    row_string = ''
    @board.each do |row|
      row.each do |col|
        case col
        when "Y"
          row_string << "\u{25CF} ".yellow
        when "R"
          row_string << "\u{25CF} ".red
        else
          row_string << "\u{25CF} ".blue
        end
      end
      puts "#{row_string}\n"
      row_string = ''
    end
    puts ""
  end

  def update_board(col, player)
    # byebug
    i = 0
    while i < @board.length
      if i.eql?(@board.length-1) || @board[i+1][col].eql?("Y") || @board[i+1][col].eql?("R")
        @board[i][col] = player.color_english
        break
      end
      i += 1
    end
  end

  def game_over?(row, col, player)

    # vertical
    # if there are four pieces in the column
      # check if they are all the same color
    color = player.color_english * 4
    if !(@board[2][col].eql?(0))
      string = @board[0][col].to_s + @board[1][col].to_s + @board[2][col].to_s + @board[3][col].to_s + @board[4][col].to_s + @board[5][col].to_s

      if string.include?(color)
        return true
      end
    end
    # horizontal
    string_horizontal = @board[row].join
    if string_horizontal.include?(color)
      return true
    end
    # byebug
    # diagonal
    ## loop from starting position to top-left
    string_diag1 = ""
    i = 0
    j = 0
    until row-i < 0 || col-j < 0 || @board[row-i][col-j].eql?(0) do
      string_diag1 << @board[row-i][col-j]
      i += 1
      j += 1
    end
    ## loop from NEXT starting position to bottom-right
    i = 1
    j = 1
    until row+i > 5 || col+j > 6 || @board[row+i][col+j].eql?(0) do
      string_diag1 << @board[row+i][col+j]
      i += 1
      j += 1
    end

    if string_diag1.include?(color)
      return true
    end

    ## loop from starting position to top-right
    string_diag2 = ""
    i = 0
    j = 0
    until row-i < 0 || col+j > 6 || @board[row-i][col+j].eql?(0) do
      string_diag2 << @board[row-i][col+j]
      i += 1
      j += 1
    end

    ## loop from NEXT starting position to bottom-left
    i = 1
    j = 1
    until row+i > 5 || col-j < 0 || @board[row+i][col-j].eql?(0) do
      string_diag2 << @board[row+i][col-j]
      i += 1
      j += 1
    end

    if string_diag2.include?(color)
      return true
    end

    false
  end

  def draw?
    byebug
    return true unless @board[0].include?(0)

    false
  end
end

# game = ConnectFour.new
# game.play_game