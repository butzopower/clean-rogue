require "clean_rogue"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue/values/item"
require "clean_rogue_test_support/doubles/gui_spy"

include CleanRogue

describe "looking at items beneath a player" do
  let(:start_position) { [0,0] }
  let(:gui_spy) { GuiSpy.new }
  let(:player) { Values::Player.new(position: start_position) }
  let(:room) { Values::Room.new(width: 2, height: 2, player: player) }

  context "given there are no items at the player's position" do
    describe "when I look at the items at my position" do
      before do
        present_items
      end

      it "then shows no items" do
        expect(gui_spy.spy_presented_items.length).to eq(0)
      end
    end
  end

  context "given there is an item at the player's position" do
    let(:item) { Values::Item.new(position: start_position) }
    let(:other_item) { Values::Item.new(position: [0,1]) }
    let(:items) { [item, other_item] }
    let(:room) { Values::Room.new(width: 2, height: 2, player: player, items: items) }

    describe "when I look at the items at my position" do
      before do
        present_items
      end

      it "then it shows the item at my position" do
        expect(gui_spy.spy_presented_items).to include(item)
      end

      it "but does not show items in other positions" do
        expect(gui_spy.spy_presented_items).not_to include(other_item)
      end
    end
  end

  def present_items
    CleanRogue.present_items_beneath_player(
        observer: gui_spy,
        room: room,
        player: player
    ).execute
  end
end