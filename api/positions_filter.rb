class PositionsFilter
  def initialize(attributes={})
    @attacks = attributes.fetch(:modes)
    @radar   = attributes.fetch(:radar)
  end

  def filter
    result = nil
    attack_modes = @attacks.modes.map(&:mode)

    # lets be human and keep our guys safe first
    if attack_modes.include? AttackMode::AVOID_CROSSFIRE
      remove_positions_with_humans
      attack_modes.delete(AttackMode::AVOID_CROSSFIRE)
    end

    # now let's fry those TX's
    if attack_modes.include? AttackMode::PRIORIZE_TX
      priorize_tx_positions
      attack_modes.delete(AttackMode::PRIORIZE_TX)
    end

    if attack_modes.include? AttackMode::FURTHEST_FIRST
      result = @radar.positions.last
    else
      result = @radar.positions.first
    end

    result || {}
  end

  private

  def remove_positions_with_humans
    @radar.positions_without_humans
  end

  def priorize_tx_positions
    @radar.positions_with_tx
    @radar.positions.each{ |p| p.priorize_tx }
  end
end
