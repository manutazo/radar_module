class RadarPositions
  attr_reader :positions

  def initialize(positions)
    @positions = positions.collect{ |rp| RadarPosition.new(rp) }
    @positions = @positions.sort{|p1, p2| p1.distance <=> p2.distance}
  end

  def self.parse(positions)
    radar_positions = new(positions)

    fail 'Invalid positions' unless radar_positions.valid_positions?

    radar_positions
  end

  def positions_specified?
    @positions.count > 0
  end

  def valid_positions?
    @positions.map(&:valid?).uniq == [true]
  end

  def positions_without_humans
    @positions.reject{ |p| p.has_humans? }
  end

  def positions_with_tx
    @positions.select{ |p| p.has_tx? }
  end

  def closest_position
    @positions.min{ |p| p.distance }
  end

  def furthest_position
    @positions.max{ |p| p.distance }
  end
end
