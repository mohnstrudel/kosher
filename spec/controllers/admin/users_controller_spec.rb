require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  render_views
  login_superadmin

  before(:each) do
    FactoryBot.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" } )
  end

  context "GET methods" do
    let(:user) { FactoryBot.build(:user) } 
    let(:created_user) { FactoryBot.create(:user) }

    # describe "#index" do  
    #   it "populates an array of users" do
   #      get :index
    #     assigns(:user).should eq([user])
    #   end

    #   it "renders the :index view" do
   #        get :index
   #        expect(response).to 
   #        response.should render_template :index
   #      end
    # end

    describe "#edit" do
      it "renders edit template" do
        get :edit, params: { id: created_user.id }
        expect(response).to render_template(:edit)
      end
    end
  end

  context "POST methods" do

    describe "#create" do
      it "using valid params" do
        
        expect{
          post :create, params: { user: { email: "something@hello.com", password: "long12345678" } }
          }.to change(User, :count).by(1)
        # get user_path('1')
      end

      it "redirects to the edit page after saving" do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        user = User.last
        expect(response).to redirect_to(edit_admin_user_path(user.id))
      end

      context "it redirects to new" do
        it "if user has no valid mail" do
          post :create, params: { user: { email: "something", password: "long12345678" } }
          expect(response).to render_template(:new)
        end
        it "if user has no valid password" do
          post :create, params: { user: { email: "something@mail.com", password: "short" } }
          expect(response).to render_template(:new)
        end
      end
    end
  end

  context "PUT methods" do

    let(:existing_user) { FactoryBot.create(:user, email: "non_updated_user@mail.com", first_name: "Tommy")}
    let(:attributes) do
      { email: "updated_user@mail.com", 
        first_name: "UpdatedTommy" }
    end

    describe "#update" do

      before(:each) do
        put :update, params: { id: existing_user.id, user: attributes }
        # put :update, id: existing_user.id, params: { user: FactoryBot.attributes_for(:user, email: "updated_user@mail.com"), first_name: "UpdatedTommy" }
        existing_user.reload
      end

      it { expect(response).to redirect_to(edit_admin_user_path(existing_user.id)) }
      it { expect(existing_user.email).to eql attributes[:email]}
    end

  end
end
