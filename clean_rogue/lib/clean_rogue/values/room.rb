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
    end
  end
end