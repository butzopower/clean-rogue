class RoomPresenter
  def initialize(background: '.')
    @background = background
  end

  def present_room(room, vision)
    player = room.player
    height = room.height
    width = room.width

    tiles =  build_positions(height, width).map do |position|
      if !vision.visible?(position)
        " "
      elsif player.position == position
        "@"
      elsif room.obstacles.any? { |obstacle| obstacle.position == position}
        "#"
      elsif room.items.any? { |item| item.position == position}
        "o"
      else
        @background
      end
    end

    tiles.each_slice(width)
      .map { |row| row.join }
      .join("\n")
  end

  private

  def build_positions(height, width)
    (0...height).to_a.flat_map do |row_index|
      (0...width).to_a.map.with_index do |column_index|
        [column_index, row_index]
      end
    end
  end
end