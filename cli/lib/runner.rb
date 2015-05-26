require "clean_rogue"
require "clean_rogue/values/player"
require "clean_rogue/values/room"
require "clean_rogue/values/obstacle"
require "clean_rogue/utils/direction"
require "room_presenter"

class Runner
  def initialize(screen, width: 15, height: 15)
    @screen = screen
    @player = CleanRogue::Values::Player.new(position: [width / 2, height / 2])

    number_of_obstacles = (width * height) / 7
    obstacles = Array.new(number_of_obstacles) { CleanRogue::Values::Obstacle.new(position: [rand(height), rand(width)])}
    @room = CleanRogue::Values::Room.new(width: width, height: height, player: @player, obstacles: obstacles)
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
