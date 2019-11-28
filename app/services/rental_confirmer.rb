class RentalConfirmer
  def initialize(car_id, rental_id, addons)
    @car ||= Car.find_by(id: car_id)
    @rental ||= Rental.find()
    @addons ||=

  def self.confirm()
     rental.rental_items.create(rentable: car, daily_rate:
                                 car.daily_rate)

     if addons = Addon.where(id: addons)
       addon_items = addons.map { |addon| addon.first_available_item }

       addon_items.each do |addon_item|
         rental.rental_items.create(rentable: addon_item,
                                    daily_rate: addon_item.addon.daily_rate)
       end

     end
     rental.update(price_projection: rental.calculate_final_price)
     rental
  end

  def self.license_plate
    ''
  end

end
