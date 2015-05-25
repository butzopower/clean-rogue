class RoomPresenter
  def present_room(room)
    player = room.player
    Array.new(room.height).map.with_index do |_, row_index|
      Array.new(room.width, '.').map.with_index do |content, column_index|
        [column_index, row_index] == player.position ? '@' : content
      end.join
    end.join("\n")
  end
end