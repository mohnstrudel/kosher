# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.kosher.ru"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add '/about'
  add '/news'
  add '/gallery'
  add '/faq'
  add '/contact'

  add '/consumers'
  add '/trade-networks'
  add '/manufacturers'

  add '/categories'

  add '/suppliers'
  add '/shops'
  add '/restaurants'
  add '/recipe_categories'
  add '/labels'
  add '/partners'

  Manufacturer.find_each do |supplier|
    supplier.products.find_each do |product|
      add supplier_product_path(supplier, product), :lastmod => product.updated_at
    end
  end

  City.find_each do |city|
    city.restaurants.find_each do |restaurant|
      add restaurant_city_path(restaurant, city), lastmod: restaurant.updated_at
    end

    city.shops.find_each do |shop|
      add shop_city_path(shop, city), lastmod: shop.updated_at
    end
  end

  RecipeCategory.find_each do |rc|
    rc.recipes.find_each do |recipe|
      add recipe_category_recipe_path(rc, recipe), lastmod: recipe.updated_at
    end
  end

end

SitemapGenerator::Sitemap.ping_search_engines(newengine: 'http://webmaster.yandex.ru/wmconsole/sitemap_list.xml?host=%s')
