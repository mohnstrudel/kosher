module Front::LinkHelper
  def upper_nav_link(name, link_path, options={}, &block)
    url = request.path_info
    class_name = url.include?(link_path) ? 'upper-current' : ''

    additional_class = " #{options[:class]}"

    link_to name, link_path, class: "g-menu__item #{class_name}#{additional_class}", &block
  end

  def lower_nav_link(name, link_path, options={}, &block)
    url = request.path_info
    
    if options[:product]
      if url.include?(link_path) or url.include?('suppliers')
        class_name = 'lower-current'
      else
        class_name = ''
      end
    else
      class_name = url.include?(link_path) ? 'lower-current' : ''
    end

    additional_class = " #{options[:class]}"

    link_to name, link_path, class: "g-menu__item #{class_name}#{additional_class}", &block
  end

  def footer_nav_link(name, link_path, options={}, &block)
    url = request.path_info
    class_name = url.include?(link_path) ? 'footer-current' : ''

    additional_class = " #{options[:class]}"

    link_to name, link_path, class: "g-menu__item #{class_name}#{additional_class}", &block
  end
end