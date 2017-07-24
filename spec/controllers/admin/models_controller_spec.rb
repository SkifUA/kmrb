require 'rails_helper'

RSpec.describe Admin::ModelsController, type: :controller do

  let(:user) { create :user }

  describe "GET models#index" do
    it "returns http success" do

      get(:index, params: { model: 'user' })
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET models#show" do
    it "returns http success" do

      get(:show, params: { model: 'user', id: user.id })
      expect(response).to have_http_status(:success)
    end
  end

end
