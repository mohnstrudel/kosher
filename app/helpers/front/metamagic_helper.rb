module Front::MetamagicHelper

  def get_meta_from_breadcrumbs(breadcrumbs)
    # Получаем крамбы в формате  [{:title=>"Магазины", :url=>"/shops"}]
    crumbs = breadcrumbs.map { |i| i[:title]}
    crumbs = crumbs.reverse!
    # logger.debug("Crumbs are: #{crumbs}")
    return crumbs
  end
end