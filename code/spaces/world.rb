class World < Space
  self.size = V[480, 270]
  self.background_color = C['#a99']

  self.things = {
    Wall => [
      (0..size.x / 16).map { |x| V[x * 16, size.y - 16] },
      (8..size.x / 16 - 12).map { |x| V[x * 16, size.y - 6 * 16] },
      V[32, size.y - 32], V[32, size.y - 48],
      V[48, size.y - 32], V[48, size.y - 48]
    ].flatten,
    Player => size / 2
  }
end
