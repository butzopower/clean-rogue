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
        new_position_x = @player.position[0] + @direction[0]
        new_position_y = @player.position[1] + @direction[1]

        if valid_move?(new_position_x, new_position_y)
          new_position = [new_position_x, new_position_y]
          updated_player = Values::Player.new(position: new_position)
          updated_room = Values::Room.new(@room.attributes.merge(player: updated_player))
          @observer.room_updated(updated_room)
        else
          @observer.action_failed("Cannot move outside of room")
        end
      end

      private

      def valid_move?(new_position_x, new_position_y)
        new_position_x >= 0 && new_position_x < @room.width &&
            new_position_y >= 0 && new_position_y < @room.height
      end
    end
  end
end