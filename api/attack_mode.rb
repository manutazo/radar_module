class AttackMode
  attr_reader :mode

  MODES = [
    'closest-first',
    'furthest-first',
    'avoid-crossfire',
    'priorize-t-x'
  ].freeze

  def initialize(attributes={})
    @mode = attributes.fetch(:mode)
  end

  def valid?
    MODES.include?(@mode)
  end
end
