class Admin < ApplicationRecord
  belongs_to :user
  belongs_to :group_admin
# TODO added validate
  # validates :user_id, presence: true
  # validates :group_id, presence: true
end
