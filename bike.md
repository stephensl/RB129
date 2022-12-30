```ruby 
class Bike 
  def initialize(wheel_size, gears, frame_material)
    @wheel_size = wheel_size
    @gears = gears
    @frame_material = frame_material
  end 


  def tune_up
    "You're all tuned up."
  end 

end 

class MtnBike
  def initialize(wheel_size, gears, frame_material, suspension)
    super(wheel_size, gears,frame_material)
    @suspension = suspension
  end 

  def jump_log
    "Oh no a log, quick, jump!"
  end 
end 

class RoadBike
  def self.class 
    class.downcase
  end 

  def win_tour_de_france
    "Holy cow, I won the TDF! I must be a #{self.class}."
  end 
end 

bianchi = RoadBike.new
puts bianchi.win_tour_de_france
