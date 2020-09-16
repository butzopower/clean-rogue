require "clean_rogue"
require "clean_rogue/utils/direction"
require "clean_rogue/utils/map_generators/random_map_generator"
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
                            room_builder: room_builder_with({height: 1, width: 2, number_of_items: 1, number_of_obstacles: 0})
  ).execute
end

Given(/^I'm in a spacious room$/) do
  CleanRogue.begin_new_game(observer: gui_spy,
                            game_repo: fake_game_repo,
                            room_builder: room_builder_with({height: 3, width: 3, number_of_obstacles: 0})
  ).execute
end

Given(/^I'm in a room with obstacles$/) do
  CleanRogue.begin_new_game(observer: gui_spy,
                            game_repo: fake_game_repo,
                            room_builder: room_builder_with({height: 1, width: 2, number_of_obstacles: 1})
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

When(/^I move left$/) do
  present_game

  CleanRogue.move_player(
    direction: Direction.W,
    room: presented_room,
    player: presented_player,
    observer: gui_spy
  ).execute
end

When(/^I look at the floor$/) do
  present_game
  
  CleanRogue.present_items_beneath_player(
      observer: gui_spy,
      room: gui_spy.spy_updated_room,
      player: gui_spy.spy_updated_room.player
  ).execute
end


Then(/^my character should move right$/) do
  player = gui_spy.spy_updated_room.player
  expect(player.position).to eq([2, 1])
end

Then(/^my character should bump into an obstacle$/) do
  expect(gui_spy.spy_updated_room).to eq(nil)
  expect(gui_spy.spy_failure_message).to eq("Movement blocked by obstacle")
end

Then(/^I should see an item$/) do
  expect(gui_spy.spy_presented_items.length).to eq(1)
end

def room_builder_with(options, seed: Random.new_seed)
  rng = Random.new(seed)
  CleanRogue::Utils::MapGenerators::RandomMapGenerator.new(room_options: options, rng: rng)
end