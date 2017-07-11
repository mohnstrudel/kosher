class Admin::SubscribersController < AdminController
  
  include CrudConcern

  before_action :find_subscriber, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    @subscribers = index_helper("Subscriber")
  end

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    create_helper(@subscriber, "edit_admin_subscriber_path")
  end

  def update
    update_helper(@subscriber, "edit_admin_subscriber_path", subscriber_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@subscriber, "admin_subscribers_path")
  end

  private

  def find_subscriber
    @subscriber = Subscriber.find(params[:id])
  end

  def subscriber_params
    params.require(:subscriber).permit(Subscriber.attribute_names.map(&:to_sym))
  end

end

