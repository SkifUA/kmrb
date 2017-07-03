module Admin::BaseHelper

  def list_models
    list = ActiveRecord::Base.connection.tables
    list - ['ar_internal_metadata', 'schema_migrations']
    # ActiveRecord::Base.connection.tables.map{|x|x.classify.safe_constantize}.compact
  end

  def to_uppercase(model)
    model.split('_').map{ |word| word.capitalize }.join(' ')
  end
end
