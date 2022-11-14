class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue

  attr_accessor :rider_log

  def initialize(ride_hash)
    @name = ride_hash[:name]
    @min_height = ride_hash[:min_height]
    @admission_fee = ride_hash[:admission_fee]
    @excitement = ride_hash[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    allowed = if visitor.tall_enough?(@min_height) && visitor.preferences.include?(@excitement)
      visitor.paid(@admission_fee)
      @rider_log[visitor] = [] << visitor
    end 
    if !allowed.nil?
      @rider_log[visitor] = allowed.length
    end
    @total_revenue += @admission_fee
  end
end
