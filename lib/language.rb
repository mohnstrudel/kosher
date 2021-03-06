module Language
  def self.get_remaining_locales
    current_locale = I18n.locale
    begin
      selected_locales = GeneralSetting.first.language
      remaining_locales = selected_locales.except(current_locale.to_s, "")
    rescue ActiveRecord::RecordNotFound
      GeneralSetting.create(url: "http://example.com", language: {"ru"=>"ru", "en" => "en"})
    end
  end

  def self.remaining_included?(current_field_name, remaining_locale)
    # as current locale we expec, for example "title_en"
    # we're splitting at the "_" symbol and take the last element
    # because there can be a title like this "some_crazy_title_en"
    # remaining_locale is an array of (one) remaning locale, for
    # example ["ru", "ru"]

    current_locale = current_field_name.to_s.split("_")[-1].to_sym
    if remaining_locale[0].to_sym == current_locale
      return true
    else
      return false
    end
  end

  def self.get_fields(lang, object)
    field_name = lang.to_s.split("_")
    field_name.pop #remove last element
    field_name = field_name.join("_") # join again with _ sign
    # To receive something like Post::Translation or User::Translation from object
    # we need to perform this crazy operation
    # object.class.model_name.name.constantize
    field_type = object.class.model_name.name.constantize::Translation.columns_hash[field_name].type
    case field_type
    when :integer
      return "number_field"
    when :text
      return "text_area"
    when :string
      return "text_field"
    end
  end

end