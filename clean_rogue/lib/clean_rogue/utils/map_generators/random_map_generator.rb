require 'clean_rogue/values/obstacle'
require 'clean_rogue/values/item'
require 'clean_rogue/values/room'
require 'clean_rogue/values/entrance'

module CleanRogue
  module Utils
    module MapGenerators
      class RandomMapGenerator
        DEFAULT_ROOM_OPTIONS = {width: 10, height: 10, number_of_obstacles: 25, number_of_items: 5}

        def initialize(room_options:, rng:)
          @rng = rng
          @options = DEFAULT_ROOM_OPTIONS.merge(room_options)
          validate
        end

        def build_room
          obstacles = build_obstacles
          items = build_items
          entrance = build_entrance

          Values::Room.new(
            width: width,
            height: height,
            player: nil,
            obstacles: obstacles,
            items: items,
            entrance: entrance
          )
        end

        private

        def build_obstacles
          random_positions_within_bounds
            .reject { |position| position == center }
            .uniq
            .map {|position| Values::Obstacle.new(position: position) }
            .first(number_of_obstacles)
        end

        def build_items
          random_positions_within_bounds
            .reject { |position| position == center }
            .map {|position| Values::Item.new(position: position) }
            .first(number_of_items)
        end

        def build_entrance
          Values::Entrance.new(position: center)
        end

        def random_positions_within_bounds
          Enumerator.new do |positions|
            loop do
              positions << [rng.rand(width), rng.rand(height)]
            end
          end.lazy
        end

        def validate
          if number_of_obstacles > area
            raise "More obstacles than can fit inside room"
          end
        end

        def width
          options[:width]
        end

        def height
          options[:height]
        end

        def area
          width * height
        end

        def center
          [width / 2, height / 2]
        end

        def number_of_obstacles
          options[:number_of_obstacles]
        end

        def number_of_items
          options[:number_of_items]
        end

        attr_reader :rng, :options
      end
    end
  end
end