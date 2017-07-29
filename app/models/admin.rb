class Admin < ApplicationRecord
  belongs_to :user
  belongs_to :group_admin

  VISIBLE_COLUMNS = [
      'id',
      'user_id',
      'group_admin_id',
      'created_at'
  ]

  EDIBLE_COLUMNS = [
      :user_id,
      :group_admin_id
  ]
# TODO added validate
  # validates :user_id, presence: true
  # validates :group_id, presence: true
end
