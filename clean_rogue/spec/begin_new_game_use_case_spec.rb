require "clean_rogue"
require "clean_rogue_test_support/doubles/gui_spy"

include CleanRogue

describe "beginning a new game" do
  let(:gui_spy) { GuiSpy.new }
  let(:room_options) { {height: 2, width: 3, number_of_obstacles: 3, number_of_items: 2} }
  let(:player_options) { {start: [1, 1]} }
  let(:seed) { rand(1000000) }

  context "given a set of options" do
    describe "when I begin a new game" do
      before do
        begin_new_game
      end

      it "creates a room" do
        expect(gui_spy.new_game_room.height).to eq(2)
        expect(gui_spy.new_game_room.width).to eq(3)
      end

      it "creates obstacles in the room" do
        expect(gui_spy.new_game_room.obstacles.size).to eq(3)
      end

      it "creates a player" do
        expect(gui_spy.new_game_player.position).to eq([1, 1])
      end

      it "creates items in the room" do
        expect(gui_spy.new_game_room.items.size).to eq(2)
      end

      it "doesnt create items on walls" do
        room = gui_spy.new_game_room
        room.items.each do |item|
          expect(room.obstacle_at?(item.position)).to be false
        end
      end

    end
  end

  context "when the game has been configured with a seed" do
    let(:seed) { 12345 }

    describe "when I begin a new game" do
      before do
        begin_new_game
      end

      it "creates the same game as if I created another game with that seed" do
        original_room_obstacle_positions = gui_spy.new_game_room.obstacles.map(&:position)

        begin_new_game
        new_room_obstacle_positions = gui_spy.new_game_room.obstacles.map(&:position)

        expect(new_room_obstacle_positions).to eq(original_room_obstacle_positions)
      end
    end
  end

  def begin_new_game
    CleanRogue.begin_new_game(observer: gui_spy,
                              room_options: room_options,
                              player_options: player_options,
                              seed: seed).execute
  end
end