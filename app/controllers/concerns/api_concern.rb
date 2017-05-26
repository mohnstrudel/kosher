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
      parent_model = parent_object.singularize.capitalize.constantize
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
      object = object.singularize.capitalize.constantize
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
    @status = 200
    object = object.singularize.capitalize.constantize
    begin
      @object = object.find(params[:id])
    rescue => e
      @object = e.message
      @status = 400
    end

    respond_to do |format|
      format.json {
        render json: @object, status: @status
      }
    end
  end
end