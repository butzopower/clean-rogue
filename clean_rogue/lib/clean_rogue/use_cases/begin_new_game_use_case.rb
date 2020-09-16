require "clean_rogue/values/room"
require "clean_rogue/values/player"
require "clean_rogue/values/obstacle"
require "clean_rogue/values/item"
require "clean_rogue/entities/game"

module CleanRogue
  module UseCases
    class BeginNewGameUseCase
      def initialize(observer:, game_repo:, room_builder:)
        @observer = observer
        @game_repo = game_repo
        @room_builder = room_builder
      end

      def execute
        room_without_player = @room_builder.build_room
        player = build_player(room_without_player.entrance)
        room = room_without_player.with_player(player)

        game = Entities::Game.new(room: room, player: player)
        @game_repo.save(game)

        @observer.new_game_began(game.id)
      end

      private

      def build_player(entrance)
        Values::Player.new(position: entrance.position)
      end
    end
  end
end