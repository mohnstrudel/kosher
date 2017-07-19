module Front::BreadcrumbsHelper
  def get_breadcrumbs
    breadcrumbs = Array.new
    path = url_for.split("/")
    path.each_with_index do |element, index|
      
      begin
        item = element.singularize.camelcase.constantize.model_name.human(count: 'other')

        # Индивидуальная

        breadcrumbs << item
      rescue NameError=>e
        logger.debug e.message
        logger.debug "For element: #{element}"
      end

      if is_number?(element)
        # Имя модели вот тут - path[index-1]
        begin
          found_object = path[index-1].singularize.camelcase.constantize.find(element.to_i)
        rescue NameError=>e
          logger.debug e
          found_object = Manufacturer.find(element.to_i)
        end
        begin
          breadcrumbs << found_object.name
        rescue NoMethodError=>e
          breadcrumbs << found_object.title
          logger.debug e
        end
      end
    end

    if breadcrumbs.length == 3
      breadcrumbs.reverse!
      breadcrumbs.pop
    end
    return breadcrumbs
  end
end