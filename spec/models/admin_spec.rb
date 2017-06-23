require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject :admin do
    Admin.new(
        user_id: 1,
        group_id: 1
    )
  end

  it 'works' do
    expect(admin).to be_a Admin
  end
end
