module CleanRogue
  module Values
    class Entrance
      def initialize(position:)
        @position = position
      end

      attr_reader :position
    end
  end
end