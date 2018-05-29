module Admin::PicturesHelper

  def image_tag_or_default(object, image_field_title, options = {})
    
    size = options[:size] || "64x64"
    version = options[:version]
    klass = options[:class]
    
    if object.send(image_field_title).try(:url).nil?
      return placeholdit_image_tag size, text: 'Kosher.ru', class: klass
    else
      begin
        tag = image_tag(object.send(image_field_title).send(version).url, class: klass)
      rescue NoMethodError, ArgumentError, TypeError
        tag = image_tag(object.send(image_field_title).url, class: klass)
      end

      return tag
    end
  end
end
