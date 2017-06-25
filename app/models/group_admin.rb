class GroupAdmin < ApplicationRecord
  has_many :admins
  NUMBER_ACCESS = [
      0, # []
      1, # [:read]
      2, # [:read, :create, :update]
      3  # [:manage]
  ]
end
