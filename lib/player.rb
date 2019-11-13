require_relative 'validation'

class Player < User
  include Validation

  validate :name, :presence

  def initialize(*args)
    super(*args)
    validate!
  end
end
