require "clean_rogue"
require "clean_rogue/values/obstacle"
require "clean_rogue/utils/direction"
require "room_presenter"

class Runner
  def initialize(screen, width: 15, height: 15)
    @screen = screen
    @room_presenter = RoomPresenter.new
    @failure_message = ""
    @width = width
    @height = height
  end

  # commands
  def start
    player_options = { start: [@width / 2, @height / 2] }
    room_options = { width: @width, height: @height, number_of_obstacles: (@width * @height / 4), number_of_items: 30 }
    CleanRogue.begin_new_game(observer: self, room_options: room_options, player_options: player_options).execute
  end

  def move_player(direction)
    CleanRogue.move_player(observer: self, direction: direction, player: @player, room: @room).execute
  end

  # callbacks
  def new_game_began(room, player)
    @room = room
    @player = player
    look
  end

  def room_updated(room)
    @room = room
    @player = room.player
    @failure_message = ""
    look
  end

  def items_presented(items)
    @items_beneath_player = items
  end

  def vision_presented(vision)
    @vision = vision
  end

  def action_failed(failure_message)
    @failure_message = failure_message
    draw
  end

  private

  def look
    CleanRogue.present_room_to_player(observer: self, player: @player, room: @room).execute
    CleanRogue.present_items_beneath_player(observer: self, player: @player, room: @room).execute

    draw
  end

  def draw
    item_message = "#{@items_beneath_player.length} item(s) here."
    presented_room = @room_presenter.present_room(@room, @vision)
    frame = "#{presented_room}\n\n#{item_message}\n\n#{@failure_message}"
    @screen.draw(frame, [], @player.position.reverse)
  end
end
