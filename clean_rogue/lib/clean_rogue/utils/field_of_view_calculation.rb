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

      # NOTE
      # The following code was taken from:
      # http://www.roguebasin.com/index.php?title=Ruby_shadowcasting_implementation

      # Multipliers for transforming coordinates into other octants
      OCTANT_MULTIPLIERS = [
          [1,  0,  0, -1, -1,  0,  0,  1],
          [0,  1, -1,  0,  0, -1,  1,  0],
          [0,  1,  1,  0,  0, -1, -1,  0],
          [1,  0,  0,  1, -1,  0,  0, -1],
      ]

      # Determines which co-ordinates on a 2D grid are visible
      # from a particular co-ordinate.
      # start_x, start_y: center of view
      # radius: how far field of view extends
      def do_fov(start_x, start_y, radius)
        light start_x, start_y
        8.times do |oct|
          cast_light start_x, start_y, 1, 1.0, 0.0, radius,
                     OCTANT_MULTIPLIERS[0][oct],OCTANT_MULTIPLIERS[1][oct],
                     OCTANT_MULTIPLIERS[2][oct], OCTANT_MULTIPLIERS[3][oct], 0
        end
      end

      # Recursive light-casting function
      def cast_light(cx, cy, row, light_start, light_end, radius, xx, xy, yx, yy, id)
        return if light_start < light_end
        radius_sq = radius * radius
        (row..radius).each do |j| # .. is inclusive
          dx, dy = -j - 1, -j
          blocked = false
          while dx <= 0
            dx += 1
            # Translate the dx, dy co-ordinates into map co-ordinates
            mx, my = cx + dx * xx + dy * xy, cy + dx * yx + dy * yy
            # l_slope and r_slope store the slopes of the left and right
            # extremities of the square we're considering:
            l_slope, r_slope = (dx-0.5)/(dy+0.5), (dx+0.5)/(dy-0.5)
            if light_start < r_slope
              next
            elsif light_end > l_slope
              break
            else
              # Our light beam is touching this square; light it
              light(mx, my) if (dx*dx + dy*dy) < radius_sq
              if blocked
                # We've scanning a row of blocked squares
                if blocked?(mx, my)
                  new_start = r_slope
                  next
                else
                  blocked = false
                  light_start = new_start
                end
              else
                if blocked?(mx, my) and j < radius
                  # This is a blocking square, start a child scan
                  blocked = true
                  cast_light(cx, cy, j+1, light_start, l_slope,
                             radius, xx, xy, yx, yy, id+1)
                  new_start = r_slope
                end
              end
            end
          end # while dx <= 0
          break if blocked
        end
      end # (row..radius+1).each
    end
  end
end