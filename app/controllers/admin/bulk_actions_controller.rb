class Admin::BulkActionsController < AdminController

  def bulk_delete
    object = params[:object]
    if params[:object_ids].is_a?(Array) && params[:object_ids].length > 1  #let's make sure we got what we expected
      @objects = object.singularize.capitalize.constantize.find(params[:object_ids])
      @objects.each do |object|
        object.destroy
      end
      flash[:success] = t('admin.flash.success.delete')
      redirect_to send("admin_#{object.pluralize}_path", sublevel: params[:sublevel])
    else
      flash[:danger] = t('admin.flash.fail.delete')
      redirect_to send("admin_#{object.pluralize}_path", sublevel: params[:sublevel])
    end
  end
end
