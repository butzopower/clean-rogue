class GuiSpy
  def room_updated(updated_room)
    @spy_updated_room = updated_room
  end

  attr_reader :spy_updated_room

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

  def vision_presented(vision)
    @spy_presented_vision = vision
  end

  attr_reader :spy_presented_vision

  def new_game_began(game_id)
    @new_game_id = game_id
  end

  attr_reader :new_game_id

  def game_presented(game)
    @presented_game = game
  end
  attr_reader :presented_game
end