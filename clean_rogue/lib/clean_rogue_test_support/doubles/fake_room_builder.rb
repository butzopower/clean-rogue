require 'clean_rogue/values/room'

class FakeRoomBuilder
  def build_room(player)
    @built_with_player = player
    @built_room = CleanRogue::Values::Room.new(width:0, height:0, player:player, obstacles: [], items: [])
    @built_room
  end

  attr_reader :built_room, :built_with_player
end