module Front::LinkHelper
  def upper_nav_link(name, link_path, options={}, &block)
    url = request.path_info
    current_url = url.include?(link_path)
    if current_url
      class_name = 'upper-current'
    else
      class_name = ''
    end

    additional_class = " #{options[:class]}"

    if current_url
      content_tag(:div, name, class: "g-menu__item #{class_name}#{additional_class} text-cursor", &block)
    else
      link_to name, link_path, class: "g-menu__item #{class_name}#{additional_class}", &block
    end
  end

  def lower_nav_link(name, link_path, options={}, &block)
    url = request.path_info

    current_url = url.include?(link_path)
    
    if options[:product]
      if current_url or url.include?('suppliers')
        class_name = 'lower-current'
      else
        class_name = ''
      end
    else
      class_name = url.include?(link_path) ? 'lower-current' : ''
    end

    additional_class = " #{options[:class]}"

    if current_url
      content_tag(:div, name, class: "g-menu__item #{class_name}#{additional_class} text-cursor", &block)
    else
      link_to name, link_path, class: "g-menu__item #{class_name}#{additional_class}", &block
    end
  end

  def footer_nav_link(name, link_path, options={}, &block)
    url = request.path_info
    current_url = url.include?(link_path)
    class_name = current_url ? 'footer-current' : ''

    additional_class = " #{options[:class]}"
    
    if current_url
      content_tag(:div, name, class: "g-menu__item #{class_name}#{additional_class} text-cursor", &block)
    else
      link_to name, link_path, class: "g-menu__item #{class_name}#{additional_class}", &block
    end
    
  end
end