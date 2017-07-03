require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do

  describe "GET dashboard#home" do
    it "returns http success" do

      get(:home, params: { user_id: 1 }, session: { user_id: 1 })
      expect(response).to have_http_status(:success)
    end
  end

end
