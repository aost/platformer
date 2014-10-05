class World < Space
  self.size = V[480, 270]
  self.background_color = C['#22a']

  self.things = {
    Wall => (8..size.x / 16 - 12).map { |x| V[x * 16, size.y - 6 * 16] },
    Ground => [
      V[32, size.y], V[48, size.y],
      V[32, size.y - 16], V[48, size.y - 16],
      V[32, size.y - 32], V[48, size.y - 32]
    ].flatten,
    GrassyGround => [
      (0..1).map { |x| V[x * 16, size.y - 16] },
      (4..size.x / 16 / 4).map { |x| V[x * 16, size.y - 16] },
      V[32, size.y - 48], V[48, size.y - 48]
    ].flatten,
    Player => size / 2
  }
end
