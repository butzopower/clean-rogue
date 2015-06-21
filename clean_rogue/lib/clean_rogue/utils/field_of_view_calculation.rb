require "clean_rogue/vendor/shadowcasting_field_of_view"

module CleanRogue
  module Utils
    class FieldOfViewCalculation
      VISION_RADIUS = 20

      def initialize(room:, player:)
        @room = room
        @player = player
      end

      def calculate_visible_positions
        @visible_positions = []
        do_fov(@player.position[0], @player.position[1], VISION_RADIUS)
        remove_visible_position_outside_of_room(@visible_positions)
      end

      private

      include ShadowcastingFieldOfView

      def blocked?(x, y)
        position = x,y
        @room.obstacle_at?(position)
      end

      def light(x, y)
        position = x,y
        unless @visible_positions.include?(position)
          @visible_positions << position
        end
      end

      def remove_visible_position_outside_of_room(positions)
        positions.reject do |position|
          @room.out_of_room_bounds?(position)
        end
      end
    end
  end
end