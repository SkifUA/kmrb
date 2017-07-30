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

  NAME_LENGTH_MAX = 25
  NAME_LENGTH_MIN = 2

  NON_GROUP_VALIDATE_ATTRS = [
      'id',
      'name',
      'created_at',
      'updated_at'
  ]

  GROUP_VALIDATE_ATTRS = self.attribute_names
                             .reject{|attr| NON_GROUP_VALIDATE_ATTRS.include?(attr)}
                             .collect {|attr| attr.to_sym}

  validates :name,
            presence: true,
            uniqueness: true,
            length: { maximum: NAME_LENGTH_MAX, minimum: NAME_LENGTH_MIN }
  validates_presence_of GROUP_VALIDATE_ATTRS

  def self.visible_columns
    VISIBLE_COLUMNS + ApplicationController.helpers.list_models.collect {|model| model.to_s.underscore}
  end

  def self.edible_columns
    EDIBLE_COLUMNS + ApplicationController.helpers.list_models.collect {|model| model.name.underscore.to_sym}
  end
end
