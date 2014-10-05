class Ground < Wall
  def graphic
    @graphic ||= Image['ground.png']
  end
end
