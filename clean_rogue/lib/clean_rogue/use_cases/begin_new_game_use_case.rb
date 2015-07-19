require "clean_rogue/values/room"
require "clean_rogue/values/player"
require "clean_rogue/values/obstacle"
require "clean_rogue/values/item"
require "clean_rogue/entities/game"

module CleanRogue
  module UseCases
    class BeginNewGameUseCase
      DEFAULT_ROOM_OPTIONS = {width: 10, height: 10, number_of_obstacles: 25, number_of_items: 5}

      def initialize(observer:, game_repo:, room_options:, player_options:, seed: Random.new_seed)
        @observer = observer
        @game_repo = game_repo
        @room_options = DEFAULT_ROOM_OPTIONS.merge(room_options)
        @player_options = player_options
        @rng = Random.new(seed)
      end

      def execute
        player = build_player(@player_options[:start])
        obstacles = build_obstacles(@room_options[:number_of_obstacles],
                                    @room_options[:width],
                                    @room_options[:height]
        )

        items = build_items(@room_options[:number_of_items],
                            @room_options[:width],
                            @room_options[:height]
        )

        room = build_room(@room_options[:width], @room_options[:height], player, obstacles, items)

        game = Entities::Game.new(room: room, player: player)
        @game_repo.save(game)

        @observer.new_game_began(game.id)
      end

      private

      def build_room(width, height, player, obstacles, items)
        Values::Room.new(width: width, height: height, player: player, obstacles: obstacles, items: items)
      end

      def build_player(start)
        Values::Player.new(position: start)
      end

      def build_obstacles(number_of_obstacles, width, height)
        Array.new(number_of_obstacles) do
          position = [@rng.rand(width), @rng.rand(height)]
          Values::Obstacle.new(position: position)
        end
      end

      def build_items(number_of_items, width, height)
        Array.new(number_of_items) do
          position = [@rng.rand(width), @rng.rand(height)]
          Values::Item.new(position: position)
        end
      end
    end
  end
end