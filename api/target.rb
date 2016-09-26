class Target
  attr_reader :type, :damage

  TYPES = [
    'Human',
    'T1',
    'T1-9',
    'T7-1',
    'T-X',
    'HK-Tank',
    'HK-Bomber',
    'HK Airstrike'
  ]

  def initialize(attributes={})
    @type   = attributes.fetch(:type)
    @damage = attributes.fetch(:damage) unless @type == 'Human'
  end

  def valid?
    TYPES.include?(@type)
  end
end
