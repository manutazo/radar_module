class PositionsFilter
  def initialize(attributes={})
    @attacks = attributes.fetch(:modes)
    @radar   = attributes.fetch(:radar)
  end

  def filter
    results = {}

    @attacks.modes.each do |attack_mode|
      case attack_mode.mode
      when AttackMode::CLOSEST_FIRST
        results = closest_position
      when AttackMode::FURTHEST_FIRST
        results = furthest_position
      when AttackMode::AVOID_CROSSFIRE
        results = remove_positions_with_humans
      when AttackMode::PRIORIZE_TX
        results = priorize_tx
      end
    end

    results.first || {}
  end

  private

  def remove_positions_with_humans
    @radar.positions_without_humans
  end

  def priorize_tx
    positions = remove_positions_without_tx
    positions.each{|p| p.priorize_tx}
  end

  def remove_positions_without_tx
    @radar.positions_with_tx
  end

  def closest_position
    [@radar.closest_position]
  end

  def furthest_position
    [@radar.furthest_position]
  end
end
