require "clean_rogue/values/player"
require "clean_rogue/values/room"

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
        new_position = [new_position_x, new_position_y]

        if move_out_of_bounds?(new_position)
          @observer.action_failed("Cannot move outside of room")
        elsif new_position_occupied(new_position)
          @observer.action_failed("Movement blocked by obstacle")
        else
          move_player_to(new_position)
        end
      end

      private

      def move_out_of_bounds?(new_position)
        new_position_x, new_position_y = new_position
        !(new_position_x >= 0 && new_position_x < @room.width &&
            new_position_y >= 0 && new_position_y < @room.height)
      end

      def new_position_occupied(new_position)
        @room.obstacles.any? {|obstacle| obstacle.position == new_position}
      end

      def move_player_to(new_position)
        updated_player = Values::Player.new(position: new_position)
        updated_room = Values::Room.new(@room.attributes.merge(player: updated_player))
        @observer.room_updated(updated_room)
      end
    end
  end
end