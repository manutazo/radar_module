class RadarPositions
  attr_reader :positions

  def initialize(positions)
    @positions = positions.collect{ |rp| RadarPosition.new(rp) }
  end

  def self.parse(positions)
    radar_positions = new(positions)

    fail 'Invalid positions'               unless radar_positions.valid_positions?
    fail 'Repeated positions not allowed'  unless radar_positions.unique_positions?

    radar_positions
  end

  def positions_specified?
    @positions.count > 0
  end

  def valid_positions?
    @positions.map(&:valid?).uniq == [true]
  end

  def unique_positions?
    positions = @positions.map(&:coordinates)
    positions.length == positions.uniq.length
  end

end
