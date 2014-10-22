class World < Space
  self.size = 480, 270
  self.background_color = Color['#22a']

  self.things = {
    Wall => (8..width / 16 - 12).map { |x| [x * 16, height - 6 * 16] },
    Ground => [
      [32, height], [48, height],
      [32, height - 16], [48, height - 16],
      [32, height - 32], [48, height - 32]
    ],
    GrassyGround => [
      (0..1).map { |x| [x * 16, height - 16] }.flatten(1),
      (4..width / 16 / 4).map { |x| [x * 16, height - 16] }.flatten(1),
      [32, height - 48], [48, height - 48]
    ],
    Player => [
      Vec2.divide(*size, 2)
    ]
  }
end
