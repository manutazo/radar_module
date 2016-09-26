class AttackModes
  attr_reader :modes

  def initialize(attack_modes)
    @modes = attack_modes.collect{ |am| AttackMode.new(mode: am) }
  end

  def self.parse(modes)
    attack_modes = new(modes)

    fail 'Attack mode unspecified'             unless attack_modes.modes_specified?
    fail 'Repeated attack modes not permitted' unless attack_modes.unique_modes?
    fail 'Invalid modes'                       unless attack_modes.valid_modes?
    fail 'Incompatible modes'                  unless attack_modes.compatible_modes?

    attack_modes
  end

  def modes_specified?
    @modes.count > 0
  end

  def valid_modes?
    @modes.map(&:valid?).uniq == [true]
  end

  def unique_modes?
    modes = @modes.map(&:mode)
    modes.length == modes.uniq.length
  end

  def compatible_modes?
    modes = @modes.map(&:mode)
    !modes.include?('furthest-first') if modes.include?('closest-first')
  end
end
