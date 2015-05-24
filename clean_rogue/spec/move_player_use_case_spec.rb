require "clean_rogue"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue_test_support/doubles/gui_spy"

include CleanRogue

describe "moving a player in a room" do
  let(:player) { Values::Player.new(position: [1,1]) }
  let(:room) { Values::Room.new(width: 2, height: 2, player: player) }
  let(:gui_spy) { GuiSpy.new }

  context "given the position next to the player is free" do
    describe "when I move the player towards that position" do
      before do
        CleanRogue.move_player(
            direction: [1,0],
            room: room,
            player: player,
            observer: gui_spy
        ).execute
      end

      specify "then the player's character should move to that position" do
        expect(gui_spy.spy_updated_room.player.position).to eq([2,1])
      end
    end
  end
end