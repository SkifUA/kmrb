class GroupAdmin < ApplicationRecord
  has_many :admins
  NUMBERS_ACCESS = [
      0, # []
      1, # [:read]
      2, # [:read, :create, :update]
      3  # [:manage]
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
end
