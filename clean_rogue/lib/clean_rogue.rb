Dir[File.join(__dir__, "clean_rogue", "use_cases", "*.rb")].each do |file|
  require file
end

module CleanRogue
  extend self

  include UseCases

  def move_player(*args)
    MovePlayerUseCase.new(*args)
  end

  def begin_new_game(*args)
    BeginNewGameUseCase.new(*args)
  end

  def present_items_beneath_player(*args)
    PresentItemsBeneathPlayerUseCase.new(*args)
  end

  def present_room_to_player(*args)
    PresentRoomToPlayerUseCase.new(*args)
  end
end