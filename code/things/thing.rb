class Thing
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def update(game)
    raise NotImplementedError
  end

  def draw(display)
    raise NotImplementedError
  end

  def x
    position.x
  end

  def y
    position.y
  end

  def z
    position.z
  end

  def width
    size.x
  end

  def height
    size.y
  end

  def solid?
    false
  end
end
