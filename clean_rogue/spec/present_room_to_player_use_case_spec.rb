require "clean_rogue"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue_test_support/doubles/gui_spy"

include CleanRogue

describe "looking around the room" do
  let(:player) { Values::Player.new(position: [0, 1]) }
  let(:all_positions) { [[0,0], [0,1], [0,2], [1,0], [1,1], [1,2], [2,0], [2,1], [2,2]] }

  context "given there are no obstacles in the room" do
    let(:room) { Values::Room.new(height: 3, width: 3, player: player) }
    describe "when the player looks around the room" do
      before do
        look_around_room
      end

      specify "then they should be able to see everything" do
        vision = gui_spy.spy_presented_vision
        all_positions_visible = all_positions.all? { |position| vision.visible? position}
        expect(all_positions_visible).to eq(true)
      end
    end
  end

  context "given there is a wall of obstacles in the room" do
    let(:obstacles) do
      [
        Values::Obstacle.new(position: [1,0]),
        Values::Obstacle.new(position: [1,1]),
        Values::Obstacle.new(position: [1,2])
      ]
    end

    let(:room) { Values::Room.new(height: 3, width: 3, player: player, obstacles: obstacles) }
    let(:blocked_positions) { [[2,0], [2,1], [2,2]] }
    let(:visible_positions) { all_positions - blocked_positions}
    describe "when the player looks around the room" do
      before do
        look_around_room
      end

      specify "then they should not be able to see through the wall" do
        vision = gui_spy.spy_presented_vision
        visible_positions_visible = visible_positions.all? { |position| vision.visible? position}
        blocked_positions_not_visible = blocked_positions.none? { |position| vision.visible? position }

        expect(visible_positions_visible).to eq(true)
        expect(blocked_positions_not_visible).to eq(true)
      end
    end
  end

  def look_around_room
    present_room_to_player(observer: gui_spy,
                           player: player,
                           room: room).execute
  end

  let(:gui_spy) { GuiSpy.new }
end