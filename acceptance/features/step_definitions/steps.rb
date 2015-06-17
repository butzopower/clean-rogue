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

Given(/^I'm in a tiny room with an item$/) do
  CleanRogue.begin_new_game(observer: gui_spy,
                            room_options: {height: 1, width: 1, number_of_items: 1},
                            player_options: { start: [0, 0] }
  ).execute
end

Given(/^I'm in a spacious room$/) do
  CleanRogue.begin_new_game(observer: gui_spy,
                            room_options: {height: 2, width: 2, number_of_obstacles: 0},
                            player_options: { start: [0, 0] }
  ).execute
end

Given(/^I'm in a room with obstacles$/) do
  seed = 5 # seed 5 will always generate an obstacle at position [1, 0]
  CleanRogue.begin_new_game(observer: gui_spy,
                            room_options: {height: 2, width: 2, number_of_obstacles: 1},
                            player_options: { start: [0, 0] },
                            seed: seed
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

Then(/^my character should bump into an obstacle$/) do
  expect(gui_spy.spy_updated_room).to eq(nil)
  expect(gui_spy.spy_failure_message).to eq("Movement blocked by obstacle")
end

When(/^I look at the floor$/) do
  player = gui_spy.new_game_player
  room = gui_spy.new_game_room

  CleanRogue.present_items_beneath_player(
      observer: gui_spy,
      room: room,
      player: player
  ).execute
end

Then(/^I should see an item$/) do
  expect(gui_spy.spy_presented_items.length).to eq(1)
end