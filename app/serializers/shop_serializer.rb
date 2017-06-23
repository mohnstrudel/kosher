class ShopSerializer < ActiveModel::Serializer

  attributes :id, :title, :description, :url, :logo, :address, :city, :phones, :opening_hours
  

  def city
    city = object.city
    if city
      {
        id: city.id,
        name: city.name
      }
    else
      return nil
    end
  end

  def phones
    object.phones.map do |phone|
      {
        id: phone.id,
        value: phone.value
      }
    end
  end

  def opening_hours
    object.opening_hours.map do |hour|
      {
        id: hour.id,
        title: hour.title,
        value: hour.value
      }
    end
  end
end
