class RoomPresenter
  def initialize(background: '.')
    @layers = build_layers(background)
  end

  def present_room(room, vision)
    height = room.height
    width = room.width

    tiles = build_positions(height, width).map do |position|
      @layers
        .find {|l| l.satisfies?(position: position, room: room, vision: vision) }
        .display
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

  def build_layers(background)
    [
      UnableToSeeTile.new(' '),
      PlayerTile.new('@'),
      ObstacleTile.new('#'),
      ItemTitle.new('o'),
      DefaultTile.new(background)
    ]
  end

  Tile = Struct.new(:display)

  class UnableToSeeTile < Tile
    def satisfies?(position:, vision:, **_)
      !vision.visible?(position)
    end
  end

  class PlayerTile < Tile
    def satisfies?(position:, room:, **_)
      room.player.position == position
    end
  end

  class ObstacleTile < Tile
    def satisfies?(position:, room:, **_)
      room.obstacles.any? { |obstacle| obstacle.position == position}
    end
  end

  class ItemTitle < Tile
    def satisfies?(position:, room:, **_)
      room.items.any? { |item| item.position == position}
    end
  end

  class DefaultTile < Tile
    def satisfies?(**_)
      true
    end
  end
end