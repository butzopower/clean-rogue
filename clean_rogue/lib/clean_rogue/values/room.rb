module CleanRogue
  module Values
    class Room
      ATTRIBUTES = [:width, :height, :player]

      def initialize(width:, height:, player:)
        @width = width
        @height = height
        @player = player
      end

      def attributes
        Hash[ATTRIBUTES.map {|attribute| [attribute, public_send(attribute)]}]
      end

      attr_reader :width, :height, :player
    end
  end
end