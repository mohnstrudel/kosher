module ApiConcern 
  extend ActiveSupport::Concern

  included do
    helper_method :create_helper, :update_helper, :destroy_helper, :index_helper
  end

  def index_helper(object, parent_object = nil, options = {})
    @status = 200
    if parent_object.present?
      parent_param = parent_object.downcase.singularize.underscore
      parent_param = "#{parent_param}_id"
    end
    
    if params[parent_param].present?

      # Проверяем, был ли передан родительский объект
      parent_model = parent_object.camelcase.singularize.constantize
      child_model_plural = object.downcase.pluralize
      child_model = object.singularize.capitalize.constantize
      parent_id_param = parent_object.singularize.underscore
      parent_id_param = "#{parent_id_param}_id"

      begin
        if child_model.method_defined?(:phones) && child_model.method_defined?(:opening_hours)
          @objects = parent_model.includes(child_model_plural.to_sym).find(params[parent_id_param.to_sym]).send(child_model_plural).includes(:phones).includes(:opening_hours)
        else
          @objects = parent_model.includes(child_model_plural.to_sym).find(params[parent_id_param.to_sym]).send(child_model_plural)
        end
      rescue => e
        @objects = e
        # @objects << "hello"
        @status = 400
      end

    else
      object = object.camelize.singularize.constantize
      if object.method_defined?(:phones) && object.method_defined?(:opening_hours)
        @objects = object.includes(:phones).includes(:opening_hours)
      else
        @objects = object.all
      end
    end

    respond_to do |format|
      format.json {
        render json: @objects, status: @status
      }
    end
  end

  def show_helper(object, parent_object = nil, options = {})
    if parent_object.present?
      parent_param = parent_object.downcase.singularize.underscore
      parent_param = "#{parent_param}_id"
    end
    @status = 200
    
    child_model_plural = object.downcase.pluralize
    object = object.camelize.singularize.constantize
    
    
    if params[parent_param].present?
      
      # Тут получаем из родительского параметра полноценный класс (например, из 'page_categories' получаем)
      # PageCategory в виде класса "Класс"
      parent_model = parent_object.camelcase.singularize.constantize
      # Получаем структуру по типу
      # PageCategory.includes(:pages).find(params[:page_category_id]).pages.find(params[:id])
      begin
        @object = parent_model.includes(child_model_plural.to_sym).find(params[parent_param.to_sym]).send(child_model_plural).find(params[:id])
      rescue => e
        @objects = e.message
        @status = 400
      end
    else
      begin
        @object = object.find(params[:id])
      rescue => e
        @object = e.message
        @status = 400
      end
    end

    respond_to do |format|
      format.json {
        render json: @object, status: @status
      }
    end
  end
end