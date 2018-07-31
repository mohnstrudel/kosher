class FrontController < ApplicationController
  layout 'front' 
  before_action :load_settings
  before_action :force_blank_request_format_to_html
  before_action :set_locale

  rescue_from ActionView::MissingTemplate do |exception|
    logger.debug "Missing template detected for path:"
    logger.debug exception.path
    # use exception.path to extract the path information
    # This does not work for partials
  end

  private

  def set_locale
    I18n.locale =  params[:locale] || session[:locale] || I18n.default_locale
    # session[:locale] = I18n.locale
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  def load_settings
    @settings = GeneralSetting.first
    @breadcrumbs = get_breadcrumbs
    logger.debug "Settings were loaded. Settings are: #{@settings.inspect}"
  end

  def force_blank_request_format_to_html
    if request[:format].blank? 
      request.format = :html 
    end
  end 

  def get_breadcrumbs
    breadcrumbs = Array.new
    path = url_for.split("/")
    puts 'url splitted at:'
    puts path.inspect
    path.shift(4)
    puts 'shifted path is:'
    puts path.inspect
    path.each_with_index do |element, index|
      begin
        url = path.first(index+1).join("/")
        url = "/#{url}"
        if index.even?
          if path.include?("suppliers") && index == 2
            item = Product.friendly.find(element)
            breadcrumbs << { title: item.title, url: url }
          elsif path.include?("recipe_categories") && index == 2
            item = Recipe.friendly.find(element)
            breadcrumbs << { title: item.title, url: url }
          else
            # "/categories/alkogolnye-napitki/suppliers/moroshka-sladkaya/products/vodka-ryabchik"
            # categories == even
            item_model_name = element.gsub(/\s(.)/) {|e| $1.upcase}.singularize.camelcase.constantize.model_name
            @previous_item = item_model_name.human(count: 'other', locale: :en)
            item = item_model_name.human(count: 'other')
            
            # Сохраняем хэш в массиве
            breadcrumbs << { title: item, url: url}
          end

        elsif index.odd?
          if path.include?("restaurants") or path.include?("shops")
            item = City.friendly.find(element)
            breadcrumbs << { title: item.name, url: url }
          else
            item = @previous_item.gsub(/\s(.)/) {|e| $1.upcase}.singularize.constantize.friendly.find(element)
            if item.try(:title)
              breadcrumbs << { title: item.title, url: url }
            else
              breadcrumbs << { title: item.name, url: url }
            end
          end
        end
      rescue NameError=>e
        # Индивидуальная
        if e.message =~ /uninitialized constant/
          # Генерируем кастомные проверки для хлебных крошек
          logger.debug "Custom breadcrumbs generation for #{element}"
          case element
          when '404'
            breadcrumbs << { title: "404", url: "/"}
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
          when 'contact'
            breadcrumbs << { title: 'Обратная связь', url: url }
          when 'search'
            breadcrumbs << { title: 'Поиск', url: url}
          end
        elsif e.message =~ /wrong constant name/
          case element
          when '404'
            breadcrumbs << { title: "404", url: "/"}
          when '500'
            breadcrumbs << { title: "500", url: "/"}
          when 'trade-networks'
            breadcrumbs << { title: 'Торговым сетям', url: url }
          else
            logger.debug "Wrong constant name for element: >#{element}<. Full error message: #{e.message}."
          end
        else
          logger.debug "Error for element: #{element}. Error message: #{e.message}"
        end
      end
    end

    return breadcrumbs
  end
end
