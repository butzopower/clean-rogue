class RoomPresenter
  def initialize(background: '.')
    @background = background
  end

  def present_room(room)
    player = room.player
    Array.new(room.height).map.with_index do |_, row_index|
      Array.new(room.width, @background).map.with_index do |content, column_index|
        position = [column_index, row_index]

        if player.position == position
          "@"
        elsif room.obstacles.any? { |obstacle| obstacle.position == position}
          "#"
        elsif room.items.any? { |item| item.position == position}
          "o"
        else
          content
        end
      end.join
    end.join("\n")
  end
end