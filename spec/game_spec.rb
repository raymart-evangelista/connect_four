require_relative '../lib/game'
require 'pry-byebug'

describe ConnectFour do
  let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
  let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
  subject(:game) { described_class.new(one, two, Array.new(6) { Array.new(7,0) }) }

  describe '#initialize' do
    context 'when player one is initialized' do
      it 'is a valid player name' do
        expect(one.name).to eq('Raymart')
      end

      it 'matches color name' do
        expect(one.color_english).to eq('Y')
      end
    end

    context 'when player two is initialized' do
      it 'is a valid player name' do
        expect(two.name).to eq('Raylph')
      end

      it 'matches color name' do
        expect(two.color_english).to eq('R')
      end
    end
  end

  describe '#ask_name' do
  end

  describe '#play_game' do
  end

  describe '#player_input' do
    context 'when user input is within range' do
      before do
        valid_input = '3'
        allow(game).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and doesnt display error message' do
        expect(game).not_to receive(:puts).with("Invalid Input!")
        game.player_input
      end
    end

    context 'when user input is not within range' do
      before do
        invalid_input = '8'
        valid_input = '7'
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'completes loop and displays error message once' do
        expect(game).to receive(:puts).with("Invalid Input!").once
        game.player_input
      end
    end
  end

  describe '#verify_input' do
    context 'when given a valid column as argument' do
      it 'returns valid column number' do
        valid_input = 3
        verified_input = game.verify_input(valid_input)
        expect(verified_input).to eq(3)
      end
    end

    context 'when given invalid input as argument' do
      it 'returns nil' do
        invalid_input = 10
        verified_input = game.verify_input(invalid_input)
        expect(verified_input).to be_nil
      end
    end
  end

  describe '#full_col?' do
    context 'when the column is not full' do
      connect_four = Array.new(6) { Array.new(7, 0) }
      subject(:not_full) { described_class.new(one, two, connect_four) }

      it 'returns false' do
        col = 0
        expect(not_full).to receive(:full_col?).and_return(false)
        not_full.full_col?(col)
      end
    end

    context 'when the column is full' do
      connect_four = Array.new(6) { Array.new(7, 0) }
      connect_four[5][0] = 'Y'
      subject(:full) { described_class.new(one, two, connect_four) }

      it 'returns true' do
        col = 0
        expect(full).to receive(:full_col?).and_return(true)
        full.full_col?(col)
      end
    end
  end

  describe '#show_interface' do
  end

  describe '#update_board' do
    context 'when column is not full and doesnt have any pieces' do
      connect_four = Array.new(6) { Array.new(7, 0) }
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:updated) { described_class.new(one, two, connect_four) }

      it 'updates board' do
        col = 0
        updated.update_board(col, one)
        expect(connect_four).to eq([
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          ["Y", 0, 0, 0, 0, 0, 0]
        ])
      end
    end
    context 'when column is not full and has one piece' do
      connect_four = Array.new(6) { Array.new(7, 0) }
      connect_four[5][0] = "Y"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:updated) { described_class.new(one, two, connect_four) }

      it 'updates board' do
        col = 0
        updated.update_board(col, one)
        expect(connect_four).to eq([
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          ["Y", 0, 0, 0, 0, 0, 0],
          ["Y", 0, 0, 0, 0, 0, 0]
        ])
      end
    end
    context 'when column is not full and has one opening left' do
      connect_four = Array.new(6) { Array.new(7, 0) }
      connect_four[5][6] = "Y"
      connect_four[4][6] = "Y"
      connect_four[3][6] = "Y"
      connect_four[2][6] = "Y"
      connect_four[1][6] = "Y"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:updated) { described_class.new(one, two, connect_four) }

      it 'updates board' do
        col = 6
        updated.update_board(col, one)
        expect(connect_four).to eq([
          [0, 0, 0, 0, 0, 0, "Y"],
          [0, 0, 0, 0, 0, 0, "Y"],
          [0, 0, 0, 0, 0, 0, "Y"],
          [0, 0, 0, 0, 0, 0, "Y"],
          [0, 0, 0, 0, 0, 0, "Y"],
          [0, 0, 0, 0, 0, 0, "Y"]
        ])
      end
    end
  end

  describe '#game_over?' do
    context 'when there are four colored pieces in a row in a column' do
      connect_four = Array.new(6) { Array.new(7, 0) }
      connect_four[5][6] = "Y"
      connect_four[4][6] = "Y"
      connect_four[3][6] = "Y"
      connect_four[2][6] = "Y"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:vertical_over) { described_class.new(one, two, connect_four) }

      it 'returns true' do
        row = 2
        col = 6
        expect(vertical_over).to be_game_over(row, col, one)
      end
    end

    context 'when there are four colored pieces in a row in a row' do
      connect_four = Array.new(6) { Array.new(7,0) }
      connect_four[5][0] = "Y"
      connect_four[5][1] = "Y"
      connect_four[5][2] = "Y"
      connect_four[5][3] = "Y"
      connect_four[5][4] = "R"
      connect_four[5][5] = "R"
      connect_four[5][6] = "R"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:horizontal_over) { described_class.new(one, two, connect_four) }

      it 'returns true' do
        row = 5
        col = 3
        expect(horizontal_over).to be_game_over(row, col, one)
      end
    end

    context 'when there are four colored pieces in a row in a top-left to bototm-right diagonal' do
      connect_four = Array.new(6) { Array.new(7,0) }
      connect_four[5][4] = "Y"
      connect_four[4][3] = "Y"
      connect_four[3][2] = "Y"
      connect_four[2][1] = "Y"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:diag1_over) { described_class.new(one, two, connect_four) }

      it 'returns true' do
        row = 2
        col = 1
        expect(diag1_over).to be_game_over(row, col, one)
      end
    end

    context 'when there are four colored pieces in a row in a top-right to bottom-left diagonal' do
      connect_four = Array.new(6) { Array.new(7,0) }
      connect_four[5][0] = "Y"
      connect_four[4][1] = "Y"
      connect_four[3][2] = "Y"
      connect_four[2][3] = "Y"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:diag2_over) { described_class.new(one, two, connect_four) }

      it 'returns true' do
        row = 2
        col = 3
        expect(diag2_over).to be_game_over(row, col, one)
      end
    end

    context 'when there arent four colored pieces in a row in a column' do
      connect_four = Array.new(6) { Array.new(7, 0) }
      connect_four[5][6] = "Y"
      connect_four[4][6] = "Y"
      connect_four[3][6] = "Y"
      connect_four[2][6] = "R"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:vertical_false) { described_class.new(one, two, connect_four) }

      it 'returns false' do
        row = 2
        col = 6
        expect(vertical_false).not_to be_game_over(row, col, two)
      end
    end

    context 'when there arent four colored pieces in a row in a row' do
      connect_four = Array.new(6) { Array.new(7, 0) }
      connect_four[5][0] = "Y"
      connect_four[5][1] = "Y"
      connect_four[5][2] = "Y"
      connect_four[5][3] = "R"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:horizontal_false) { described_class.new(one, two, connect_four) }

      it 'returns false' do
        row = 5
        col = 3
        expect(horizontal_false).not_to be_game_over(row, col, two)
      end
    end

    context 'when there arent four colored pieces in a row in a top-left to bottom-right diagonal' do
      connect_four = Array.new(6) { Array.new(7,0) }
      connect_four[5][4] = "Y"
      connect_four[4][3] = "Y"
      connect_four[3][2] = "Y"
      connect_four[2][1] = "R"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:diag1_false) { described_class.new(one, two, connect_four) }

      it 'returns false' do
        row = 2
        col = 1
        expect(diag1_false).not_to be_game_over(row, col, two)
      end
    end

    context 'when there arent four colored pieces in a row in a top-right to bottom-left diagonal' do
      connect_four = Array.new(6) { Array.new(7,0) }
      connect_four[5][0] = "Y"
      connect_four[4][1] = "Y"
      connect_four[3][2] = "Y"
      connect_four[2][3] = "R"
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:diag2_false) { described_class.new(one, two, connect_four) }

      it 'returns false' do
        row = 2
        col = 3
        expect(diag2_false).not_to be_game_over(row, col, two)
      end
    end
  end
  
  describe '#draw?' do
    context 'when all positions are filled' do
      connect_four = Array.new(6) { Array.new(7,0) }
      connect_four[5] = %w[R Y R Y R Y R]
      connect_four[4] = %w[R Y R Y R Y R]
      connect_four[3] = %w[R Y R Y R Y R]
      connect_four[2] = %w[Y R Y R Y R Y]
      connect_four[1] = %w[Y R Y R Y R Y]
      connect_four[0] = %w[Y R Y R Y R Y]
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:draw_true) { described_class.new(one, two, connect_four) }

      it 'returns true' do
        expect(draw_true).to be_draw
      end
    end

    context 'when not all positions are filled' do
      connect_four = Array.new(6) { Array.new(7,0) }
      connect_four[5] = %w[R Y R Y R Y R]
      connect_four[4] = %w[R Y R Y R Y R]
      connect_four[3] = %w[R Y R Y R Y R]
      connect_four[2] = %w[Y R Y R Y R Y]
      connect_four[1] = %w[Y R Y R Y R Y]
      let(:one) { instance_double(Player, name: 'Raymart', color_english: "Y") }
      let(:two) { instance_double(Player, name: 'Raylph', color_english: "R") }
      subject(:draw_false) { described_class.new(one, two, connect_four) }

      it 'returns false' do
        expect(draw_false).not_to be_draw
      end
    end
  end
end