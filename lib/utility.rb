module Utility

  def pretty_url
    url = self.url
    if (URI::regexp(%w(http https)) =~ url) == nil
      url = "http://#{url}"
    end
    return url
  end

  # def self.set_slug(object)
  #   byebug
  #   unless object.nil?
  #     begin
  #       slugged = object.title.parameterize
  #       if object.class.friendly.find(slugged).present?
  #         hash = Rails.application.config.hashids.encode(rand(99999))
  #         slugged = "#{slugged}-#{hash}"
  #         object.slug = slugged
  #       else
  #         object.slug = slugged
  #       end
  #     rescue => e
  #       puts "Error while saving slug for #{object.inspect}. Error message: #{e.message}"
  #       object.slug = nil
  #     end
  #   end
  # end
end