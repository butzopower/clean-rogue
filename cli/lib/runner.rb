require "clean_rogue"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue/utils/direction"
require "room_presenter"

class Runner
  def initialize(screen)
    @screen = screen
    @player = CleanRogue::Values::Player.new(position: [2,2])
    @room = CleanRogue::Values::Room.new(width: 15, height: 5, player: @player)
    @room_presenter = RoomPresenter.new
    @failure_message = ""
  end

  def move_player(direction)
    CleanRogue.move_player(observer: self, direction: direction, player: @player, room: @room).execute
  end

  def draw
    presented_room = @room_presenter.present_room(@room)
    frame = "#{presented_room}\n\n#{@failure_message}"
    @screen.draw(frame, [], @player.position.reverse)
  end

  def room_updated(room)
    @room = room
    @player = room.player
    @failure_message = ""
    draw
  end

  def action_failed(failure_message)
    @failure_message = failure_message
    draw
  end
end
