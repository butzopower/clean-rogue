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
        end

        def build_room(player)
          height = options[:height]
          width = options[:width]

          obstacles = build_obstacles(options[:number_of_obstacles],
                                      width,
                                      height
          )

          items = build_items(options[:number_of_items],
                              width,
                              height
          )

          Values::Room.new(
            width: width,
            height: height,
            player: player,
            obstacles: obstacles,
            items: items
          )
        end

        private

        def build_obstacles(number_of_obstacles, width, height)
          Array.new(number_of_obstacles) do
            position = [rng.rand(width), rng.rand(height)]
            Values::Obstacle.new(position: position)
          end
        end

        def build_items(number_of_items, width, height)
          Array.new(number_of_items) do
            position = [rng.rand(width), rng.rand(height)]
            Values::Item.new(position: position)
          end
        end

        attr_reader :rng, :options
      end
    end
  end
end