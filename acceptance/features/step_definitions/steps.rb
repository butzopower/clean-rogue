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
  @player = CleanRogue::Values::Player.new(position: [1,1])
  @room = CleanRogue::Values::Room.new(width: 2, height: 2, player: @player)
end

When(/^I move right$/) do
  CleanRogue.move_player(
      direction: Direction.E,
      room: @room,
      player: @player,
      observer: gui_spy
  ).execute
end

Then(/^my character should move right$/) do
  player = gui_spy.spy_updated_room.player
  expect(player.position).to eq([2,1])
end