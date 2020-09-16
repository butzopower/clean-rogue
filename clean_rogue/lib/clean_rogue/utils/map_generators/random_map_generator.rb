require 'clean_rogue/values/obstacle'
require 'clean_rogue/values/item'
require 'clean_rogue/values/room'

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

        def build_room(player)
          obstacles = build_obstacles
          items = build_items

          Values::Room.new(
            width: width,
            height: height,
            player: player,
            obstacles: obstacles,
            items: items
          )
        end

        private

        def build_obstacles
          random_positions_within_bounds
            .uniq
            .take(number_of_obstacles)
            .map {|position| Values::Obstacle.new(position: position) }
            .to_a
        end

        def build_items
          random_positions_within_bounds
            .take(number_of_items)
            .map {|position| Values::Item.new(position: position) }
            .to_a
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