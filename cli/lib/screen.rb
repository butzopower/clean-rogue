class Screen
  def initialize(screen)
    @screen = screen
  end

  def present(view)
    frame = view.contents.join("\n")
    screen.draw(frame, [], [-1, -1])
  end

  private

  attr_reader :screen
end