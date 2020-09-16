require 'clean_rogue/values/room'
require 'clean_rogue/values/entrance'

class FakeRoomBuilder
  def initialize(entrance_position)
    @entrance_position = entrance_position
  end

  def build_room
    @built_room = CleanRogue::Values::Room.new(
      width:0,
      height:0,
      player:nil,
      obstacles: [],
      items: [],
      entrance: CleanRogue::Values::Entrance.new(position: @entrance_position)
    )

    @built_room
  end

  attr_reader :built_room
end