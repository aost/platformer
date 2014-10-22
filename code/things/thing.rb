class Thing
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def update(game)
    raise NotImplementedError
  end

  def draw(display)
    raise NotImplementedError
  end

  def solid?
    false
  end
end
