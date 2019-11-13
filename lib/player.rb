require_relative 'validation'

class Player < User
  include Validation

  validate :name, :presence

  def initialize(*args)
    super(*args)
    validate!
  end

  def choices
    full? ? %i[skip open] : %i[skip open add]
  end
end
