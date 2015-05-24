module CleanRogue
  module Values
    class Player
      def initialize(position:)
        @position = position
      end

      attr_reader :position
    end
  end
end