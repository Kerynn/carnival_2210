class Visitor
  attr_reader :name,
              :height,
              :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money
    @preferences = []
  end

  def spending_money
    @spending_money.delete('$').to_i
  end

  def add_preferences(preference)
    @preferences << preference
  end

  def tall_enough?(threshold)
    @height >= threshold
  end
end
