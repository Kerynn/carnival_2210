class Carnival
  attr_reader :duration,
              :rides


  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by do |ride|
      ride.rider_log.map do |visitor|
        visitor.count
      end
    end
  end

  def most_profitable_ride
    @rides.max_by do |ride|
      ride.total_revenue
    end
  end

  def total_rides_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end 
  end
end
