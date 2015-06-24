module CleanRogue
  module UseCases
    class DropItemUseCase
      def initialize(observer:, room:, player:, item: nil)
        @observer = observer
        @room = room
        @player = player
        @item = item
      end

      def execute
        if @item != nil
          drop_item(@item)
        end
        @observer.items_presented(get_items_at_player_position)
        @observer.player_items(@player)
      end

      private

      def drop_item(item)
        @player.drop(item)
        @room.add_item(item)
      end

      def get_items_at_player_position
        @room.items.select { |item| item.position == @player.position }
      end
    end
  end
end