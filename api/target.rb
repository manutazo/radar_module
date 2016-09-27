class Target
  attr_reader :type, :damage

  HUMAN = 'Human'.freeze
  TX    = 'T-X'.freeze

  TYPES = [
    HUMAN,
    TX,
    'T1', # not on the doc, but on the tests
    'T1-9',
    'T7-1',
    'T7-T', # not on the doc, but on the tests
    'HK-Tank',
    'HK-Bomber',
    'HK Airstrike'
  ]

  def initialize(attributes={})
    @type   = attributes.fetch(:type)
    @damage = attributes.fetch(:damage) unless @type == HUMAN
  end

  def valid?
    TYPES.include?(@type)
  end

  def is_human?
    @type == HUMAN
  end

  def is_tx?
    @type == TX
  end
end
