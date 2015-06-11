require "clean_rogue"
require "clean_rogue/utils/direction"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue_test_support/doubles/gui_spy"

module AcceptanceDSL
  def gui_spy
    @gui_spy ||= GuiSpy.new
  end
end

World(AcceptanceDSL)

Given(/^I'm in a spacious room$/) do
  CleanRogue.begin_new_game(observer: gui_spy,
                            room_options: {height: 2, width: 2},
                            player_options: { start: [0, 0] }
  ).execute
end

When(/^I move right$/) do
  @player = gui_spy.new_game_player
  @room = gui_spy.new_game_room

  CleanRogue.move_player(
      direction: Direction.E,
      room: @room,
      player: @player,
      observer: gui_spy
  ).execute
end

Then(/^my character should move right$/) do
  player = gui_spy.spy_updated_room.player
  expect(player.position).to eq([1, 0])
end