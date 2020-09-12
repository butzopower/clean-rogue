require "clean_rogue"
require "clean_rogue_test_support/doubles/gui_spy"
require "clean_rogue_test_support/doubles/fake_game_repo"
require "clean_rogue_test_support/doubles/fake_room_builder"

describe "beginning a new game" do
  let(:gui_spy) { GuiSpy.new }
  let(:player_options) { {start: [1, 1]} }
  let(:fake_game_repo) { FakeGameRepo.new }
  let(:fake_room_builder) { FakeRoomBuilder.new }

  describe "when I begin a new game" do
    before do
      begin_new_game
      present_game(gui_spy.new_game_id)
    end

    it "creates a room using the room builder" do
      expect(presented_room).to eq(built_room)
    end

    it "creates the room with the player" do
      expect(player_room_built_with).to eq(presented_player)
    end

    it "creates a player" do
      expect(presented_player.position).to eq([1, 1])
    end
  end

  def begin_new_game
    CleanRogue.begin_new_game(observer: gui_spy,
                              player_options: player_options,
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

  def player_room_built_with
    fake_room_builder.built_with_player
  end

  def built_room
    fake_room_builder.built_room
  end
end