#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "dispel"
require "curses"
require "runner"
require "inv_runner"

KEY_PAD_TO_DIRECTIONS = {
    "1" => Direction.SW,
    "2" => Direction.S,
    "3" => Direction.SE,
    "4" => Direction.W,
    "5" => Direction.WAIT,
    "6" => Direction.E,
    "7" => Direction.NW,
    "8" => Direction.N,
    "9" => Direction.NE
}

Dispel::Screen.open do |screen|
  @runner = Runner.new(screen)
  @runner.start

  Dispel::Keyboard.output do |key|
    if @runner.continue
      case key
        when "d" then
          @runner.drop_item
        when "5", "p" then
          @runner.pick_up_item
        when "i" then
          Curses.clear
          Dispel::Screen.open do |inv_screen|
            @inv_runner = InvRunner.new(inv_screen, @runner.room)
            @inv_runner.draw
            Dispel::Keyboard.output do |key1|
              case key1
                when "i" then
                  break
                when "8", :up then
                  @inv_runner.scroll(Direction.UP)
                when "2", :down then
                  @inv_runner.scroll(Direction.DOWN)
                # when :enter
                #   @inv_runner.select
              end
            end
          end
          @runner.draw
        when "1".."9" then
          @runner.move_player(KEY_PAD_TO_DIRECTIONS[key])
        when :up then
          @runner.move_player(Direction.N)
        when :down then
          @runner.move_player(Direction.S)
        when :left then
          @runner.move_player(Direction.W)
        when :right then
          @runner.move_player(Direction.E)
        when "r" then
          @runner.start
        when "q" then
          break
      end
    else
      case key
        when "r" then
          @runner.start
        when "q" then
          break
      end
    end
  end
end
