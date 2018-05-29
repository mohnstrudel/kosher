module FrontHelper
  def published_date(object)
    if object.published_at.present?
      Russian::strftime(object.published_at, "%d %B %Y")
    else
      Russian::strftime(object.created_at, "%d %B %Y")
    end
  end

  def logo_tag_or_default(object, options = {})
    thumb = options[:thumb]
    if object.logo.present?
      if object.logo.send(thumb).present?
        return image_tag(object.logo.send(thumb).url, class: options[:class])
      end
    else
      return placeholdit_image_tag "345x252", text: "No image", class: options[:class]
    end
  end

  # def image_tag_or_default(object, options = {})

  #   thumb = options[:thumb] 
  #   size = options[:size] || "64x64"
  #   klass = options[:class] || ""
  #   text = options[:text] || "Kosher.ru"
  #   url = object.url
  #   if url.present? && thumb.present?
  #     image = object.send(thumb).url
  #     return image_tag(image, class: klass)
  #   elsif url.present?
  #     return image_tag(url, class: klass)
  #   else
  #     return placeholdit_image_tag size, text: text, class: klass
  #   end
  # end
end
