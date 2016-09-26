class RadarPosition
  attr_reader :coordinates, :targets

  def initialize(attributes = {})
    initialize_coordinates(attributes.fetch(:position))
    initialize_targets(attributes.fetch(:targets))
  end

  def valid?
    valid_targets?
  end

  private

  def valid_targets?
    @targets.map(&:valid?).uniq == [true]
  end

  def initialize_coordinates(position)
    @coordinates = {
      x: position.fetch(:x).to_i,
      y: position.fetch(:y).to_i
    }
  end

  def initialize_targets(targets)
    @targets = targets.collect{ |target_attributes| Target.new(target_attributes) }
  end
end
