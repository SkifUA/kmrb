class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

if Rails.env == 'development' || Rails.env == 'test'
  require_dependency 'user'
  require_dependency 'admin'
  require_dependency 'group_admin'
end