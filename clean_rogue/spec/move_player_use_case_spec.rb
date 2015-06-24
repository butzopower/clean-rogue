require "clean_rogue"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue/values/obstacle"
require "clean_rogue_test_support/doubles/gui_spy"

include CleanRogue

describe "moving a player in a room" do
  let(:player) { Values::Player.new(position: [0,0]) }
  let(:gui_spy) { GuiSpy.new }

  context "given the position next to the player is free" do
    let(:room) { Values::Room.new(width: 2, height: 2, player: player) }
    let!(:player_health) {player.health}

    describe "when I move the player towards that position" do
      before do
        move_right
      end

      specify "then the player's character should move to that position" do
        expect(gui_spy.spy_updated_room.player.position).to eq([1,0])
      end

      specify "then the player's health decreases by 1" do
        expect(gui_spy.spy_updated_room.player.health).to eq(player_health - 1)
      end
    end
  end

  context "given the player is at 0 health" do
    let(:deadplayer) { Values::Player.new(position:[0,0], health: 0)}
    let(:room) { Values::Room.new(width: 2, height: 2, player: deadplayer) }

    describe "when I try to move" do
      before do
        move_right
      end

      specify "then I shouldnt move" do
        expect(gui_spy.spy_updated_room.player.position).to eq([0,0])
      end
    end
  end

  context "given the position next to the player is out of the room's bounds" do
    let(:room) { Values::Room.new(width: 1, height: 1, player: player) }

    describe "when I move the player towards that position" do
      before do
        move_right
      end

      specify "then the player should receive a message the move is invalid" do
        expect(gui_spy.spy_failure_message).to eq("Cannot move outside of room")
      end
    end
  end

  context "given the position next to the player is occupied by an obstacle" do
    let(:obstacle) { Values::Obstacle.new(position: [1,0]) }
    let(:room) { Values::Room.new(width: 2, height: 2, player: player, obstacles: [obstacle]) }

    describe "when I move the player towards that position" do
      before do
        move_right
      end

      specify "then the player should receive a message the move is invalid" do
        expect(gui_spy.spy_failure_message).to eq("Movement blocked by obstacle")
      end
    end
  end

  def move_right
    CleanRogue.move_player(
        direction: [1,0],
        room: room,
        player: player,
        observer: gui_spy
    ).execute
  end
end