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

  validates_uniqueness_of :user_id


  def self.visible_columns
    VISIBLE_COLUMNS
  end

  def self.edible_columns
    EDIBLE_COLUMNS
  end
end
