require 'rails_helper'

RSpec.describe GroupAdmin, type: :model do
  let(:group_admin) { create :group_admin }

  it 'works' do
    expect(group_admin).to be_a GroupAdmin
  end

  it 'is valid' do
    expect(group_admin).to be_valid
  end
end
