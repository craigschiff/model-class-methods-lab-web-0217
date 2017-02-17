class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    catamaran = joins(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
#    sailors = joins(:classifications).where(classifications: {name: "Sailboat"}).uniq
    get_boat_type("Sailboat")
  end

  def self.get_boat_type(name)
    joins(:classifications).where(classifications: {name: "#{name}"}).uniq
#    get_boat_type("Sailors")
  end

  def self.talented_seamen
#    arr_sail = joins(:classifications)
#    .where(classifications: {name: "Sailboat"}, classifications: {name: "Motorboat"}).uniq
#    arr_motor = joins(:classifications).where(classifications: {name: "Motorboat"}).uniq
#    binding.pry
#    arr_sail_and_motor = arr_motor.map do |motor|
#      if Boat.sailors.names.includes? (motor.name)
#        motor
#      end
#    end
  mb = get_boat_type("Motorboat").pluck(:id)
  sb = get_boat_type("Sailboat").pluck(:id)
  both = mb & sb
  Captain.where(id: (both))
  end

  def self.non_sailors
    sail = get_boat_type("Sailboat").pluck(:id)
    not_sail = Captain.all.pluck(:id) - sail
    Captain.where(id: (not_sail))
  end



end
