module CleanRogue
  module Values
    class Player
      def initialize(position:, items: [], health: 100, strength: 0)
        @position = position
        @items = items
        @health = health
        @strength = strength
      end

      attr_reader :position, :items, :health

      def move(position)
        @health -= 1
        @position = position
      end

      def pickUp(item)
        @items << item
      end

      def drop(item)
        @items.delete(item)
      end
    end
  end
end