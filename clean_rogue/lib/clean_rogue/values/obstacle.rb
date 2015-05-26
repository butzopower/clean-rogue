module CleanRogue
  module Values
    class Obstacle
      def initialize(position:)
        @position = position
      end

      attr_reader :position
    end
  end
end