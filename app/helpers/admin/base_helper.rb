module Admin::BaseHelper

  def list_models
    list = ActiveRecord::Base.connection.tables.map{|x| x.classify}
    list - ['ArInternalMetadatum', 'SchemaMigration']
    # ActiveRecord::Base.connection.tables.map{|x|x.classify.safe_constantize}.compact
  end
end
