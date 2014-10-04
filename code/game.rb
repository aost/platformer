require 'things/thing'
require 'things/wall'
require 'things/player'
require 'spaces/space'
require 'spaces/world'

class Platformer < Game
  attr_accessor :space

  def setup
    display.size = V[480, 270]
    ticker.rate = 30

    @space = World.new
  end

  def update(elapsed)
    @space.update(elapsed, self)
    @space.draw(display)

    display.fill_color = C['#000']
    display.fill_text(ticker.actual_rate, V[display.width - 32, 32])
  end
end
