module Front::BreadcrumbsHelper
  def get_breadcrumbs
    controller = params[:controller]
    controller_name = controller.split("/")[1]

    case controller_name
    when "posts"
      return 'Кошерные новости'
    end
  end
end