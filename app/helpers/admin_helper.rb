module AdminHelper
  
  def create_link_text_helper(object)
    model = object.model.model_name.human
    if I18n.locale == :en
      text = "Create new #{model.downcase}"
      return text
    elsif I18n.locale == :ru
      begin
        try_gender = Morpher.new("#{model}")
        gender = try_gender.singular('род')
        if gender == "Мужской"
          new_text = "Новый"
        elsif gender == "Женский"
          new_text = "Новая"
        else
          new_text = "Новое"
        end
        text = Morpher.new("#{new_text} #{model}")
        # p = Petrovich(lastname: new_text, firstname:  model)
        create_text = "Создать #{text.singular("в").downcase}"
        return create_text
      rescue => e
        logger.info "Error while translating text: #{e.message}"
        return "Создать новую запись"
      end
    end
  end

  def object_name(object)
    return object.model.name.underscore if object.is_a?(ActiveRecord::Relation)

    object = check_sti_class(object)
    object.class.name.underscore
  end

  def check_sti_class(object)
    return object if object.class == object.class.base_class

    object.becomes(object.class.base_class)
  end

  def admin_form_arguments_builder(object, namespace=nil)
    object = check_sti_class(object)

    return [:admin, object] unless namespace

    namespace = namespace.tr('_','')
    [:admin, namespace.to_sym, object]
  end

  def nav_link(link_path, options={}, &block)
    class_name = current_page?(link_path) ? 'active' : ''
    additional_class = " #{options[:class]}"
    sublevel = options[:sublevel]

    content_tag(:li, :class => "#{class_name}#{additional_class}") do
      link_to link_path, sublevel: sublevel, &block
    end
  end

  def custom_field(field, options = {})
    return send("text_field", field, options)
  end

  def breadcrumbs
    # Session breadcrumbs is defines in the admin_controller via a before_action filter
    bc = session[:breadcrumbs]

    begin
      # Пробуем, является ли последний элемент названием модели
      last_element = bc.last.singularize.constantize.model_name.human(count: 2)
    rescue
      last_element = bc.last
    end

    @content = content_tag("h2", last_element)
    @content << content_tag(:ol, class: "breadcrumb") do
        bc.collect do |crumb|

          begin
            # Пробуем, является ли crumb названием модели
            crumb = crumb.singularize.constantize.model_name.human(count: 2)
          rescue

            crumb
          end

          case crumb
          when "Admin"
            crumb = t('admin.form.misc.main')
          when "New"
            curmb = t('admin.form.actions.new.noun')
          when "Edit"
            crumb = t('admin.form.actions.edit.noun')
          end

          if crumb.equal? bc.last
            content_tag(:li, "<strong>#{crumb}</strong>".html_safe, class: "active")
          else
            content_tag(:li, crumb)
          end
        end.join.html_safe
      end

    # End result should look like this:
    #  %h2 Static Tables
    #  %ol.breadcrumb
    #   %li
    #    %a{:href => "index.html"} Home
    #   %li
    #    %a Tables
    #   %li.active
    #    %strong Static Tables

    return @content
  end

  def link_to_add_fields(name, f, association, partial_path=nil, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      if partial_path
        render(partial_path, f: builder)
      else
        render(association.to_s.singularize + "_fields", f: builder)
      end
    end
    link_to(name, '#', class: 'add_fields ' + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

end
