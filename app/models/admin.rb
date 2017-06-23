class Admin < ApplicationRecord
  belongs_to :user
# TODO added validate
  # validates :user_id, presence: true
  # validates :group_id, presence: true
end
