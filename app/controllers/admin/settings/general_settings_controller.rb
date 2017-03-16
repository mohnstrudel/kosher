class Admin::Settings::GeneralSettingsController < AdminController
  include CrudConcern

  before_action :find_general_setting, only: [:edit, :destroy, :update]

  def index
    @general_settings = GeneralSetting.all
  end

  def new
    @general_setting = GeneralSetting.new
    # Билдим для того, что бы было видно сразу одно поле и пользователь не должен
    # кликать на "добавить телефон"
    @general_setting.phones.build
    @general_setting.opening_hours.build
  end

  def edit
    # Тоже самое, что и с нью - если телефонов нет вообще, то показываем одно пустое поле
    if @general_setting.phones.blank?
      @general_setting.phones.build
    end

    if @general_setting.opening_hours.blank?
      @general_setting.opening_hours.build
    end
  end

  def create
    @general_setting = GeneralSetting.new(general_setting_params)
    create_helper(@general_setting, "edit_admin_settings_general_setting_path")
  end

  def destroy
    destroy_helper(@general_setting, "admin_settings_general_settings_path")
  end

  def update
    # debug
    # @general_setting.update(language: create_hash(params[:general_setting][:language]))
    @general_setting.language = create_hash(params[:general_setting][:language])
    update_helper(@general_setting, "edit_admin_settings_general_setting_path", general_setting_params)
  end


  private

  def find_general_setting
    @general_setting = GeneralSetting.find(params[:id])
  end

  def general_setting_params
    params.require(:general_setting).permit(GeneralSetting.attribute_names.map(&:to_sym).push(
      phones_attributes: [:id, :value, :_destroy, :general_setting_id ]).push(
      opening_hours_attributes: [:id, :title, :value, :_destroy, :deneral_setting_id]) )
  end

  def create_hash(params)
    language_hash = Hash.new

    params.each do |param|
      language_hash[param.to_sym] = param.to_sym
    end
    return language_hash
  end
end
