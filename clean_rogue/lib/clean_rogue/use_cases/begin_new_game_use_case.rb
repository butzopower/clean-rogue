require "clean_rogue/values/room"
require "clean_rogue/values/player"
require "clean_rogue/values/obstacle"
require "clean_rogue/values/item"
require "clean_rogue/entities/game"

module CleanRogue
  module UseCases
    class BeginNewGameUseCase
      def initialize(observer:, game_repo:, player_options:, room_builder:)
        @observer = observer
        @game_repo = game_repo
        @room_builder = room_builder
        @player_options = player_options
      end

      def execute
        player = build_player(@player_options[:start])
        room = @room_builder.build_room(player)

        game = Entities::Game.new(room: room, player: player)
        @game_repo.save(game)

        @observer.new_game_began(game.id)
      end

      private

      def build_player(start)
        Values::Player.new(position: start)
      end
    end
  end
end