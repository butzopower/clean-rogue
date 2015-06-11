require "clean_rogue/values/room"

module CleanRogue
  module UseCases
    class BeginNewGameUseCase
      def initialize(observer:, room_options:, player_options:)
        @observer = observer
        @room_options = room_options
        @player_options = player_options
      end

      def execute
        player = build_player(@player_options[:start])
        room = build_room(@room_options[:width], @room_options[:height], player)

        @observer.new_game_began(room, player)
      end

      private

      def build_room(width, height, player)
        Values::Room.new(width: width, height: height, player: player)
      end

      def build_player(start)
        Values::Player.new(position: start)
      end
    end
  end
end