module CleanRogue
  module Values
    class Item
      def initialize(position:)
        @position = position
      end

      attr_accessor :position

      def toString()
        position.to_s + "\n"
      end
    end
  end
end