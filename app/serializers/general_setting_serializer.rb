class GeneralSettingSerializer < ActiveModel::Serializer
  attributes :id, :url, :logo, :description, :address, :email, :opening_hours, :phones

  def phones
    object.phones.map do |phone|
      {
        id: phone.id,
        phone: phone.value
      }
    end
  end

  def opening_hours
    object.opening_hours.map do |oh|
      {
        id: oh.id,
        opening_value_words: oh.title,
        opening_hours: oh.value
      }
    end
  end
  
end
