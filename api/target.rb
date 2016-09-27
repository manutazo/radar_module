class Target
  attr_reader :type, :damage

  INVALID = 'invalid'.freeze
  HUMAN   = 'Human'.freeze
  TX      = 'T-X'.freeze

  TYPES = [
    HUMAN,
    TX,
    'T1-9',
    'T7-1',
    'HK-Tank',
    'HK-Bomber',
    'HK Airstrike',
    'T1', # not on the doc, but on the tests
    'T7-T' # not on the doc, but on the tests
  ]

  def initialize(attributes={})
    if attributes.kind_of?(Array)
      @type   = INVALID
      @damage = nil
    else
      @type   = attributes.fetch(:type)
      @damage = attributes.fetch(:damage) unless @type == HUMAN
    end
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
