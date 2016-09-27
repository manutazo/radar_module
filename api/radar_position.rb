class RadarPosition
  attr_reader :coordinates, :targets, :distance

  ORIGIN = {x: 0, y: 0}

  def initialize(attributes = {})
    initialize_coordinates(attributes.fetch(:position))
    initialize_targets(attributes.fetch(:targets))
    @distance = distance_to_origin
  end

  def valid?
    valid_targets?
  end

  def to_json
    JSON.generate({
      position: { x: @coordinates[:x], y: @coordinates[:y] },
      targets: @targets.reject{ |t| t.is_human? }.map(&:type).reverse
    })
  end

  def has_humans?
    @targets.map(&:is_human?).any?
  end

  def has_tx?
    @targets.map(&:is_tx?).any?
  end

  private

  def distance_to_origin
    x_distance = @coordinates[:x] - ORIGIN[:x]
    y_distance = @coordinates[:y] - ORIGIN[:y]

    Math.sqrt(x_distance**2 + y_distance**2)
  end

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
