module Front::MetamagicHelper

  def get_meta_from_breadcrumbs(breadcrumbs)
    # Получаем крамбы в формате  [{:title=>"Магазины", :url=>"/shops"}]
    breadcrumbs.map { |i| i[:title]}
  end
end