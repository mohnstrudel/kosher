class Geocoder

  attr_accessor :url

  def initialize
    self.url = "https://geocode-maps.yandex.ru/1.x/?format=json&geocode="
  end

  def encode(address)
    address = URI.encode(address)
    data = JSON.load(open(url+address))

    geoobjects = data["response"]["GeoObjectCollection"]["featureMember"]
    # If there are multiple GeoObjects, always return first one

    # This returns string like "37.594234 55.771428"
    long_lat = geoobjects[0]["GeoObject"]["Point"]["pos"]
    return long_lat.split(" ").map(&:to_f)
  end
end