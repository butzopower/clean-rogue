class GuiSpy
  def room_updated(updated_room)
    @spy_updated_room = updated_room
  end

  attr_reader :spy_updated_room
end