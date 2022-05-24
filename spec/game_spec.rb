require_relative '../lib/game'

describe ConnectFour do

  let(:one) { instance_double(Player, name: 'Raymart', color_code: "\u{1f7e1}", color_english: "yellow") }
  let(:two) { instance_double(Player, name: 'Raylph', color_code: "\u{1f534}", color_english: "red") }
  subject(:game) { described_class.new(one, two) }

  describe '#initialize' do
    context 'when player one is initialized' do
      it 'is a valid player name' do
        expect(one.name).to eq('Raymart')
      end
      
      it 'matches color code' do
        expect(one.color_code).to eq("\u{1f7e1}")
      end

      it 'matches color name' do
        expect(one.color_english).to eq('yellow')
      end
    end

    context 'when player two is initialized' do
      it 'is a valid player name' do
        expect(two.name).to eq('Raylph')
      end

      it 'matches color code' do
        expect(two.color_code).to eq("\u{1f534}")
      end

      it 'matches color name' do
        expect(two.color_english).to eq('red')
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
  end

  describe '#create_interface' do
  end

  describe '#show_interface' do
  end

  describe '#update_interface' do
  end

  describe '#game_over?' do
  end
  
  describe '#draw?' do
  end

  describe '#winner?' do
  end
end