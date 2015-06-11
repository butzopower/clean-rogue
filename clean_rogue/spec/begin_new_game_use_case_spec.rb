require "clean_rogue"
require "clean_rogue_test_support/doubles/gui_spy"

include CleanRogue

describe "beginning a new game" do
  let(:gui_spy) { GuiSpy.new }
  let(:room_options) { {height: 2, width: 3} }
  let(:player_options) { {start: [1, 1]} }

  context "given a set of options" do
    describe "when I begin a new game" do
      before do
        begin_new_game
      end

      it "creates a room" do
        expect(gui_spy.new_game_room.height).to eq(2)
        expect(gui_spy.new_game_room.width).to eq(3)
      end

      it "creates a player" do
        expect(gui_spy.new_game_player.position).to eq([1, 1])
      end
    end
  end

  def begin_new_game
    CleanRogue.begin_new_game(observer: gui_spy,
                              room_options: room_options,
                              player_options: player_options).execute
  end
end