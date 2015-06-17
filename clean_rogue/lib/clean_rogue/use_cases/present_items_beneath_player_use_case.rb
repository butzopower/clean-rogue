module CleanRogue
  module UseCases
    class PresentItemsBeneathPlayerUseCase
      def initialize(observer:, room:, player:)
        @observer = observer
        @room = room
        @player = player
      end

      def execute
        items = get_items_at_player_position
        @observer.items_presented(items)
      end

      private

      def get_items_at_player_position
        @room.items.select { |item| item.position == @player.position }
      end
    end
  end
end