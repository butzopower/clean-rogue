module CleanRogue
  module Values
    class Room
      ATTRIBUTES = [:width, :height, :player, :obstacles, :items]

      def initialize(width:, height:, player:, obstacles: [], items: [])
        @width = width
        @height = height
        @player = player
        @obstacles = obstacles
        @items = items
      end

      def attributes
        Hash[ATTRIBUTES.map {|attribute| [attribute, public_send(attribute)]}]
      end

      attr_reader *ATTRIBUTES

      def out_of_room_bounds?(position)
        !(position[0] >= 0 && position[0] < width &&
            position[1] >= 0 && position[1] < height)
      end

      def obstacle_at?(position)
        obstacles.any? {|obstacle| obstacle.position == position}
      end

      def remove_item(item)
        @items.delete(item)
      end

      def add_item(item)
        item.position = @player.position
        @items << item
      end
    end
  end
end