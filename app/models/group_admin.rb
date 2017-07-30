class GroupAdmin < ApplicationRecord
  has_many :admins
  NUMBERS_ACCESS = [
      0, # []
      1, # [:read]
      2, # [:read, :create, :update]
      3  # [:manage]
  ]
  VISIBLE_COLUMNS = [
      'id',
      'name',
      'created_at'
  ]

  EDIBLE_COLUMNS = [
      :id,
      :name
  ]
  validates :user,
            presence: true,
            inclusion: { in: NUMBERS_ACCESS }

  validates :admin,
            presence: true,
            inclusion: { in: NUMBERS_ACCESS }

  validates :group_admin,
            presence: true,
            inclusion: { in: NUMBERS_ACCESS }

  def self.visible_columns
    VISIBLE_COLUMNS + ApplicationController.helpers.list_models.collect {|model| model.to_s.underscore}
  end

  def self.edible_columns
    EDIBLE_COLUMNS + ApplicationController.helpers.list_models.collect {|model| model.name.underscore.to_sym}
  end
end
