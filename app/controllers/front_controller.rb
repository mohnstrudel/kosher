class FrontController < ApplicationController
  layout 'front' 
  before_action :load_settings
  before_action :force_blank_request_format_to_html

  rescue_from ActionView::MissingTemplate do |exception|
    logger.debug "Missing template detected for path:"
    logger.debug exception.path
    # use exception.path to extract the path information
    # This does not work for partials
  end

  private

  def load_settings
    @settings = GeneralSetting.first
    @breadcrumbs = get_breadcrumbs
  end

  def force_blank_request_format_to_html
    if request[:format].blank? 
      request.format = :html 
    end
  end 

  def get_breadcrumbs
    breadcrumbs = Array.new
    path = url_for.split("/")
    path.shift(3)
    puts "path is: #{path} and its length is: #{path.length}. While url is: #{url_for}"
    path.each_with_index do |element, index|
      p "Index is: #{index}"
      begin
        url = path.first(index+1).join("/")
        url = "/#{url}"
        if index.even?
          # "/categories/alkogolnye-napitki/suppliers/moroshka-sladkaya/products/vodka-ryabchik"
          # categories == even
          item_model_name = element.singularize.camelcase.constantize.model_name
          @previous_item = item_model_name.human(count: 'other', locale: :en)
          item = item_model_name.human(count: 'other')
          # Здесь мы получаем из "posts" -> "posts_path" и ищем для него его раут (/news в данном случае)
          
          # Сохраняем хэш в массиве
          breadcrumbs << { title: item, url: url}

        elsif index.odd?
          puts "Previous item is: #{@previous_item}"
          item = @previous_item.singularize.constantize.friendly.find(element)
          if item.try(:title)
            breadcrumbs << { title: item.title, url: url }
          else
            breadcrumbs << { title: item.name, url: url }
          end
        end
      rescue NameError=>e
        # Индивидуальная
        if e.message =~ /uninitialized constant/
          # Генерируем кастомные проверки для хлебных крошек
          logger.debug "Custom breadcrumbs generation for #{element}"
          case element
          when 'news'
            breadcrumbs << { title: "Новости", url: '/news' }
            @previous_item = "Post"
          when 'about'
            breadcrumbs << { title: "О Департаменте", url: url }
          when 'gallery'
            breadcrumbs << { title: 'Фотогалерея', url: url }
          when 'trade-networks'
            breadcrumbs << { title: 'Торговым сетям', url: url }
          when 'consumers'
            breadcrumbs << { title: 'Потребителям', url: url }
          when 'suppliers'
            breadcrumbs << { title: 'Производители', url: url}
            @previous_item = "Manufacturer"
          when 'partners'
            breadcrumbs << { title: 'Партнеры', url: url }
          end
        else
          logger.debug "Error for element: #{element}. Error message: #{e.message}"
        end
      end
    end

    return breadcrumbs
  end
end
