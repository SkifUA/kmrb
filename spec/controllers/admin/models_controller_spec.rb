require 'rails_helper'

RSpec.describe Admin::ModelsController, type: :controller do
  let(:group_admin) { build :group_admin }
  let(:user) { build :user }
  let(:admin) { build :admin }

  before do
    user.save(validate: false)
    admin.save(validate: false)
    group_admin.save(validate: false)
    session[:user_id] = user.id
  end


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
