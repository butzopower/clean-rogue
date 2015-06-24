module CleanRogue
  module UseCases
    class PickUpItemsBeneathPlayerUseCase
      def initialize(observer:, room:, player:)
        @observer = observer
        @room = room
        @player = player
      end

      def execute
        pick_up_items_beneath_player
        items = get_items_at_player_position
        @observer.items_presented(items)
        @observer.player_items(@player)
      end

      private

      def pick_up_items_beneath_player()
        item = get_items_at_player_position[0]
        if item != nil
          @player.pickUp(item)
          @room.remove_item(item)
        end
      end

      def get_items_at_player_position
        @room.items.select { |item| item.position == @player.position }
      end
    end
  end
end