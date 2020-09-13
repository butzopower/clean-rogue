require 'clean_rogue/values/room'
require 'clean_rogue/values/player'
require 'clean_rogue/values/vision'
require 'clean_rogue/values/obstacle'
require 'clean_rogue/values/item'

require 'room_presenter'

describe 'presenting a room' do
  it 'can display a simple room with full vision' do
    room = CleanRogue::Values::Room.new(
      width: 5,
      height: 3,
      player: CleanRogue::Values::Player.new(position: [2, 1])
    )

    vision = CleanRogue::Values::Vision.new(
      visible_positions: all_positions_for(5, 5)
    )

    display = presenter.present_room(room, vision)
    expect(display).to eq(".....\n..@..\n.....")
  end

  describe 'with modified vision' do
    it 'hides the non-visible positions' do
      room = CleanRogue::Values::Room.new(
        width: 3,
        height: 3,
        player: CleanRogue::Values::Player.new(position: [1, 1])
      )

      vision = CleanRogue::Values::Vision.new(
        visible_positions: all_positions_for(3, 3).reject { |_, y| y == 2 }
      )

      display = presenter.present_room(room, vision)
      expect(display).to eq("...\n.@.\n   ")
    end
  end

  describe 'with obstacles' do
    it 'displays the obstacles' do
      room = CleanRogue::Values::Room.new(
        width: 3,
        height: 3,
        player: CleanRogue::Values::Player.new(position: [1, 1]),
        obstacles: [
          CleanRogue::Values::Obstacle.new(position: [0,0]),
          CleanRogue::Values::Obstacle.new(position: [1,0]),
          CleanRogue::Values::Obstacle.new(position: [2,0])
        ]
      )

      vision = CleanRogue::Values::Vision.new(
        visible_positions: all_positions_for(3, 3)
      )

      display = presenter.present_room(room, vision)
      expect(display).to eq("###\n.@.\n...")
    end
  end

  describe 'with items' do
    it 'displays the items' do
      room = CleanRogue::Values::Room.new(
        width: 3,
        height: 3,
        player: CleanRogue::Values::Player.new(position: [1, 1]),
        items: [
          CleanRogue::Values::Item.new(position: [0,0]),
          CleanRogue::Values::Item.new(position: [1,0]),
          CleanRogue::Values::Item.new(position: [2,0])
        ]
      )

      vision = CleanRogue::Values::Vision.new(
        visible_positions: all_positions_for(3, 3)
      )

      display = presenter.present_room(room, vision)
      expect(display).to eq("ooo\n.@.\n...")
    end

    it 'displays the player above the items' do
      room = CleanRogue::Values::Room.new(
        width: 1,
        height: 1,
        player: CleanRogue::Values::Player.new(position: [0, 0]),
        items: [
          CleanRogue::Values::Item.new(position: [0,0])
        ]
      )

      vision = CleanRogue::Values::Vision.new(visible_positions: [[0,0]])

      display = presenter.present_room(room, vision)
      expect(display).to eq("@")
    end
  end

  def all_positions_for(height, width)
    (0...height).to_a.product((0...width).to_a)
  end

  let(:presenter) { RoomPresenter.new(background: '.') }
end