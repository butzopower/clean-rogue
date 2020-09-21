require 'clean_rogue/values/obstacle'
require 'clean_rogue/values/item'
require 'clean_rogue/values/room'
require 'clean_rogue/values/entrance'

module CleanRogue
  module Utils
    module MapGenerators
      class CaveMapGenerator
        DEFAULT_ROOM_OPTIONS = {width: 10, height: 10, initial_obstacles: 25, number_of_items: 5}

        def initialize(room_options:, rng:)
          @rng = rng
          @options = DEFAULT_ROOM_OPTIONS.merge(room_options)
        end

        def build_room
          initial_obstacle_positions = build_obstacle_positions
          obstacle_positions = initial_obstacle_positions

          4.times do
            obstacle_positions = smooth(obstacle_positions)
          end

          obstacles = obstacle_positions.map {|position| Values::Obstacle.new(position: position) }
          items = build_items(obstacle_positions)
          entrance = build_entrance(obstacle_positions)

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

        def build_obstacle_positions
          all_positions
              .shuffle(random: rng)
              .first(initial_obstacles)
        end

        def build_items(obstacle_positions)
          random_positions_within_bounds
              .reject { |position| obstacle_positions.include?(position) }
              .map {|position| Values::Item.new(position: position) }
              .first(number_of_items)
        end

        def build_entrance(obstacle_positions)
          entrance_position = (all_positions - obstacle_positions).sample
          Values::Entrance.new(position: entrance_position)
        end

        def random_positions_within_bounds
          Enumerator.new do |positions|
            loop do
              positions << all_positions.sample(random: rng)
            end
          end.lazy
        end

        def all_positions
          @all_positions ||= (0...width).to_a.product((0...height).to_a)
        end

        def width
          options[:width]
        end

        def height
          options[:height]
        end

        def initial_obstacles
          options[:initial_obstacles]
        end

        def number_of_items
          options[:number_of_items]
        end

        def smooth(positions)
          Concurrent::Array[*all_positions].reject do |position|
            obstacles_in_region(position, positions).length < 5
          end
        end

        def obstacles_in_region(position, positions)
          region = [
              [-1,-1],
              [0,-1,],
              [1,-1],
              [-1,0],
              [0,0],
              [1,0],
              [-1,1],
              [0,1],
              [1,1],
          ].map do |offset|
            [
              offset[0] + position[0],
              offset[1] + position[1]
            ]
          end

          region & positions
        end

        attr_reader :rng, :options
      end
    end
  end
end