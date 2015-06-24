require "clean_rogue"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue/values/obstacle"
require "clean_rogue/values/item"
require "clean_rogue_test_support/doubles/gui_spy"

include CleanRogue

describe "moving a player in a room" do
  let(:start_position) { [0,0] }
  let(:gui_spy) { GuiSpy.new }
  let(:item) { Values::Item.new(position: start_position) }
  let(:other_item) { Values::Item.new(position: [0,1]) }
  let(:player) { Values::Player.new(position: start_position, items: [item]) }

  context "given the player has items" do
    let(:room) { Values::Room.new(width: 2, height: 2, player: player, items: [other_item]) }

    describe "when I drop items" do
      before do
        drop_item
      end

      it "then there is no item in the player's inventory" do
        expect(gui_spy.spy_player_items).not_to include(item)
      end

      it "then there is an item at the dropped position" do
        expect(gui_spy.spy_presented_items).to include(item)
      end
    end
  end


  def drop_item
    CleanRogue.drop_item(
        observer: gui_spy,
        room: room,
        player: player
    ).execute
  end
end
