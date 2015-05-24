module CleanRogue
  module UseCases
    class MovePlayerUseCase
      def initialize(observer:, direction:, room:, player:)
        @observer = observer
        @direction = direction
        @room = room
        @player = player
      end

      def execute
        new_position = [@player.position[0] + @direction[0], @player.position[1] + @direction[1]]
        updated_player = Values::Player.new(position: new_position)
        updated_room = Values::Room.new(@room.attributes.merge(player: updated_player))
        @observer.room_updated(updated_room)
      end
    end
  end
end