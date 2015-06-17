module CleanRogue
  module Values
    class Item
      def initialize(position:)
        @position = position
      end

      attr_reader :position
    end
  end
end