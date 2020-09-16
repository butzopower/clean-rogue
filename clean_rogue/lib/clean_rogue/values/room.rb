module CleanRogue
  module Values
    class Room
      ATTRIBUTES = [:width, :height, :player, :obstacles, :items, :entrance]

      def initialize(width:, height:, player:, obstacles: [], items: [], entrance:nil)
        @width = width
        @height = height
        @player = player
        @obstacles = obstacles
        @items = items
        @entrance = entrance
      end

      def attributes
        Hash[ATTRIBUTES.map {|attribute| [attribute, public_send(attribute)]}]
      end

      def with_player(player)
        Values::Room.new(attributes.merge(player: player))
      end

      attr_reader *ATTRIBUTES

      def out_of_room_bounds?(position)
        !(position[0] >= 0 && position[0] < width &&
            position[1] >= 0 && position[1] < height)
      end

      def obstacle_at?(position)
        obstacles.any? {|obstacle| obstacle.position == position}
      end
    end
  end
end