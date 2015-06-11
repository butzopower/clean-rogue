require "clean_rogue/use_cases/move_player_use_case"
require "clean_rogue/use_cases/begin_new_game_use_case"

module CleanRogue
  extend self

  include UseCases

  def move_player(*args)
    MovePlayerUseCase.new(*args)
  end

  def begin_new_game(*args)
    BeginNewGameUseCase.new(*args)
  end
end