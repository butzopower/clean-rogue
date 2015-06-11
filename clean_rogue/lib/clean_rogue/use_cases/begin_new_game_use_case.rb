require "clean_rogue/values/room"
require "clean_rogue/values/player"
require "clean_rogue/values/obstacle"

module CleanRogue
  module UseCases
    class BeginNewGameUseCase
      DEFAULT_ROOM_OPTIONS = {width: 10, height: 10, number_of_obstacles: 25}

      def initialize(observer:, room_options:, player_options:)
        @observer = observer
        @room_options = DEFAULT_ROOM_OPTIONS.merge(room_options)
        @player_options = player_options
      end

      def execute
        player = build_player(@player_options[:start])
        obstacles = build_obstacles(@room_options[:number_of_obstacles],
                                    @room_options[:width],
                                    @room_options[:height]
        )

        room = build_room(@room_options[:width], @room_options[:height], player, obstacles)

        @observer.new_game_began(room, player)
      end

      private

      def build_room(width, height, player, obstacles)
        Values::Room.new(width: width, height: height, player: player, obstacles: obstacles)
      end

      def build_player(start)
        Values::Player.new(position: start)
      end

      def build_obstacles(number_of_obstacles, width, height)
        Array.new(number_of_obstacles) do
          position = [rand(width), rand(height)]
          Values::Obstacle.new(position: position)
        end
      end
    end
  end
end