#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "dispel"
require "runner"

Dispel::Screen.open do |screen|
  @runner = Runner.new(screen)
  @runner.draw

  Dispel::Keyboard.output do |key|
    case key
      when :up then
        @runner.move_player(Direction.N)
      when :down then
        @runner.move_player(Direction.S)
      when :left then
        @runner.move_player(Direction.W)
      when :right then
        @runner.move_player(Direction.E)
      when "q" then
        break
    end
  end
end