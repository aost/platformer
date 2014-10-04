class Wall < Thing
  GRAPHIC = Image['wall.png']

  def update(game)
  end

  def draw(d)
    d.image(GRAPHIC, @position)
  end

  def size
    GRAPHIC.size
  end

  def solid?
    true
  end
end
