require "clean_rogue"
require "clean_rogue_test_support/doubles/gui_spy"
require "clean_rogue_test_support/doubles/fake_game_repo"
require "clean_rogue_test_support/doubles/fake_room_builder"

describe "beginning a new game" do
  let(:gui_spy) { GuiSpy.new }
  let(:start_position) { [1,1] }
  let(:fake_game_repo) { FakeGameRepo.new }
  let(:fake_room_builder) { FakeRoomBuilder.new(start_position) }

  describe "when I begin a new game" do
    before do
      begin_new_game
      present_game(gui_spy.new_game_id)
    end

    it "creates a room using the room builder" do
      expect(presented_room.height).to eq(built_room.height)
      expect(presented_room.width).to eq(built_room.width)
      expect(presented_room.obstacles).to eq(built_room.obstacles)
      expect(presented_room.items).to eq(built_room.items)
      expect(presented_room.entrance).to eq(built_room.entrance)
    end

    it "creates the player at the position of the entrance" do
      expect(presented_player.position).to eq(start_position)
    end
  end

  def begin_new_game
    CleanRogue.begin_new_game(observer: gui_spy,
                              room_builder: fake_room_builder,
                              game_repo: fake_game_repo,
                              ).execute
  end

  def present_game(game_id)
    CleanRogue.present_game(observer: gui_spy,
                            game_repo: fake_game_repo,
                            game_id: game_id
    ).execute
  end

  def presented_room
    gui_spy.presented_game.room
  end

  def presented_player
    gui_spy.presented_game.player
  end

  def built_room
    fake_room_builder.built_room
  end
end