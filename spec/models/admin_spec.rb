require 'rails_helper'
# TODO added validate
RSpec.describe Admin, type: :model do
  subject :admin do
    Admin.new(
        user_id: 1,
        group_id: 1
    )
  end
  # let(:admin) { create :admin }

  it 'works' do
    expect(admin).to be_a Admin
  end

  # it 'is valid' do
  #   expect(admin).to be_valid
  # end

end
