class ShopSerializer < ActiveModel::Serializer

  attributes :id, :title, :description, :url, :logo, :address, :city, :phones, :opening_hours
  

  def city
    CitySimpleSerializer.new(object.city, root: false)
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
