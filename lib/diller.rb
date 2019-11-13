class Diller < User
  def to_s_hide
    "#{name}: #{cards_to_s_hide}"
  end

  private

  def cards_to_s_hide
    hand.to_h.keys.map { '*' }.join(' ')
  end
end
