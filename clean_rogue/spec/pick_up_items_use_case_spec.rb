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
  let(:player) { Values::Player.new(position: start_position) }
  # let!(:player_strength)
  let(:room) { Values::Room.new(width: 2, height: 2, player: player) }

  context "given there is an item at the player's position" do
    let(:item) { Values::Item.new(position: start_position) }
    let(:other_item) { Values::Item.new(position: [0,1]) }
    let(:items) { [item, other_item] }
    let(:room) { Values::Room.new(width: 2, height: 2, player: player, items: items) }

    describe "when I pick up items" do
      before do
        pick_up_items
      end

      it "then it picks up the item at my position" do
        expect(gui_spy.spy_player_items).to include(item)
        expect(gui_spy.spy_presented_items).not_to include(item)
      end

      it "but does not pick up items in other positions" do
        expect(gui_spy.spy_player_items).not_to include(other_item)
      end

      # it "increases player strength" do
      #   expect(gui_spy.spy_updated_room.player.strength).to eq()
      # end
    end
  end

  def pick_up_items
    CleanRogue.pick_up_items_beneath_player(
        observer: gui_spy,
        room: room,
        player: player
    ).execute
  end
end
