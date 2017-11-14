require 'rails_helper'

RSpec.describe Front::ErrorsController, type: :controller do

  describe "GET #not_found" do
    it "returns 404 (not found)" do
      get :not_found
      expect(response).to have_http_status(404)
    end
  end

  describe "GET #internal_server_error" do
    it "returns 500 (internal server error)" do
      get :internal_server_error
      expect(response).to have_http_status(500)
    end
  end

end
