require "clean_rogue"
require "clean_rogue/utils/direction"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue_test_support/doubles/gui_spy"
require "clean_rogue_test_support/doubles/fake_game_repo"

module AcceptanceDSL
  def gui_spy
    @gui_spy ||= GuiSpy.new
  end

  def fake_game_repo
    @fake_game_repo ||= FakeGameRepo.new
  end

  def game_id
    gui_spy.new_game_id
  end

  def present_game
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
end

World(AcceptanceDSL)

Given(/^I'm in a tiny room with an item$/) do
  CleanRogue.begin_new_game(observer: gui_spy,
                            game_repo: fake_game_repo,
                            room_options: {height: 1, width: 1, number_of_items: 1},
                            player_options: { start: [0, 0] }
  ).execute
end

Given(/^I'm in a spacious room$/) do
  CleanRogue.begin_new_game(observer: gui_spy,
                            game_repo: fake_game_repo,
                            room_options: {height: 2, width: 2, number_of_obstacles: 0},
                            player_options: { start: [0, 0] }
  ).execute
end

Given(/^I'm in a room with obstacles$/) do
  seed = 5 # seed 5 will always generate an obstacle at position [1, 0]
  CleanRogue.begin_new_game(observer: gui_spy,
                            game_repo: fake_game_repo,
                            room_options: {height: 2, width: 2, number_of_obstacles: 1},
                            player_options: { start: [0, 0] },
                            seed: seed
  ).execute
end

When(/^I move right$/) do
  present_game

  CleanRogue.move_player(
      direction: Direction.E,
      room: presented_room,
      player: presented_player,
      observer: gui_spy
  ).execute
end

When(/^I look at the floor$/) do
  present_game
  
  CleanRogue.present_items_beneath_player(
      observer: gui_spy,
      room: presented_room,
      player: presented_player
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

Then(/^I should see an item$/) do
  expect(gui_spy.spy_presented_items.length).to eq(1)
end