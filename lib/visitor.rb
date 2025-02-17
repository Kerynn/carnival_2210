class Visitor
  attr_reader :name,
              :height,
              :preferences,
              :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money
    @spending_money = spending_money.delete('$').to_i
    @preferences = []
  end

  def add_preferences(preference)
    @preferences << preference
  end

  def tall_enough?(threshold)
    @height >= threshold
  end

  def paid(admission_fee)
    @spending_money -= admission_fee
  end
end
