class AttackMode
  attr_reader :mode

  CLOSEST_FIRST   = 'closest-first'.freeze
  FURTHEST_FIRST  = 'furthest-first'.freeze
  AVOID_CROSSFIRE = 'avoid-crossfire'.freeze
  PRIORIZE_TX     = 'priorize-t-x'.freeze

  MODES = [CLOSEST_FIRST, FURTHEST_FIRST, AVOID_CROSSFIRE, PRIORIZE_TX].freeze

  def initialize(attributes={})
    @mode = attributes.fetch(:mode)
  end

  def valid?
    MODES.include?(@mode)
  end
end
