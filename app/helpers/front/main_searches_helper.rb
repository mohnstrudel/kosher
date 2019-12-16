module Front::MainSearchesHelper
  def search_title_helper(result)
    result.searchable_type.constantize.friendly.find(result.searchable_id).title
  end

  def search_link_helper(result)
    if result.searchable_type == "Manufacturer"
      supplier = Manufacturer.friendly.find(result.searchable_id)
      return send("supplier_path", supplier.slug)
    elsif result.searchable_type == 'Product'
      product = Product.friendly.find(result.searchable_id)
      logger.debug "Product is: #{product.inspect}"
      supplier = product.manufacturer
      begin
        if product.slug.present? && supplier.slug.present?
          return send("supplier_product_path", supplier.slug, product.slug)
        else
          return send("supplier_product_path", supplier.id, product.id)
        end
      rescue NoMethodError => e
        return send("#{result.searchable_type.downcase}_path", result.searchable_id)
        logger.debug "Error in search_link_helper: #{e.message}"
      end
    else
      return send("#{result.searchable_type.downcase}_path", result.searchable_id)
    end
  end

  def search_content_helper(result)
    object = result.searchable_type.constantize.friendly.find(result.searchable_id)
    value = ""
    # puts "Object is: #{object.inspect}"
    if object.try(:description).present?
      value = object.description
    elsif object.try(:body).present?
      value = object.body
    else
      value = result.content
    end
    value = strip_tags(value.capitalize)
    value = truncate(value, length: 200)
    return value
  end
end
