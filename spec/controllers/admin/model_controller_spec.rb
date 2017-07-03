require 'rails_helper'

RSpec.describe Admin::ModelController, type: :controller do

  describe "GET models#index" do
    it "returns http success" do

      get(:index, params: { model: 'user' })
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET models#show" do
    it "returns http success" do

      get(:show, params: { model: 'user', id: 1 })
      expect(response).to have_http_status(:success)
    end
  end

end
