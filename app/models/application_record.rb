class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  attr_accessor :destroyed
  after_destroy :mark_as_destroyed
  def mark_as_destroyed
    self.destroyed = true
  end
end

if Rails.env == 'development' || Rails.env == 'test'
  require_dependency 'user'
  require_dependency 'admin'
  require_dependency 'group_admin'
end