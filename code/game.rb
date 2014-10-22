require 'things/thing'
require 'things/wall'
require 'things/ground'
require 'things/grassy_ground'
require 'things/player'
require 'spaces/space'
require 'spaces/world'

class PlatformerGame < Game
  attr_accessor :space

  def setup
    display.size = 480, 270
    ticker.rate = 30

    @space = World.new
  end

  def update(elapsed)
    @space.update(elapsed, self)
    @space.draw(display)

    display.fill_color = Color['#000']
    display.fill_text(ticker.ticks_per_second, display.width - 32, 32)
  end
end
