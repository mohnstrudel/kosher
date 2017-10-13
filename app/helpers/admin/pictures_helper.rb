module Admin::PicturesHelper

  def image_tag_or_default(object, image_field_title, options = {})
    
    version = options[:version]
    if object.send(image_field_title).try(:url).nil?
      return placeholdit_image_tag "50x50", text: 'Нет картинки', class: options[:class]
    else
      begin
        tag = image_tag(object.send(image_field_title).send(version).url, class: options[:class])
      rescue NoMethodError, ArgumentError
        tag = image_tag(object.send(image_field_title).url, class: options[:class])
      end

      return tag
    end
  end
end
