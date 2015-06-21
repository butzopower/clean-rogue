module CleanRogue
  module Values
    class Vision
      def initialize(visible_positions:)
        @visible_positions = visible_positions
      end

      attr_reader :visible_positions

      def visible?(position)
        visible_positions.include?(position)
      end
    end
  end
end