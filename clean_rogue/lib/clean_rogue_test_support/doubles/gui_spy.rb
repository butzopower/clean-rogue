class GuiSpy
  def room_updated(updated_room)
    @spy_updated_room = updated_room
  end

  attr_reader :spy_updated_room

  def new_game_began(room, player)
    @new_game_room = room
    @new_game_player = player
  end

  attr_reader :new_game_room
  attr_reader :new_game_player

  def action_failed(failure_message)
    @spy_failure_message = failure_message
  end

  def spy_failure_message
    @spy_failure_message
  end

  attr_reader :spy_failure_message

  def items_presented(items)
    @spy_presented_items = items
  end

  attr_reader :spy_presented_items
end