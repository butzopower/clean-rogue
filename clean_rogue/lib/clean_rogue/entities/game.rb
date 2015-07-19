module CleanRogue
  module Entities
    class Game
      attr_accessor :id, :player, :room

      def initialize(player:, room:)
        @player = player
        @room = room
      end
    end
  end
end