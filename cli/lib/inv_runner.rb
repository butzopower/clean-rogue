require "clean_rogue"
require "clean_rogue/values/obstacle"
require "clean_rogue/utils/direction"
require "room_presenter"

class InvRunner
  def initialize(screen, room)
    @screen = screen
    @room = room
    @selected = 0
  end

  def scroll(direction)
    @selected = (@selected + direction) % @room.player.items.length
    draw
  end

  def drop
    CleanRogue.drop_item(observer: self, player: @player, room: @room, item: room.player.items[@selected]).execute
  end


  def draw
    inventory = ""
    @room.player.items.each do |item|
      inventory += item.toString()
    end
    @screen.draw("inventory\n#{inventory}", [], [@selected + 1,0])
  end

end
