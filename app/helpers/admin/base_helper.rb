module Admin::BaseHelper

  def list_models
    ActiveRecord::Base
            .descendants
            .select! { |m| not_table.exclude? m.to_s }
  end

  def to_uppercase(model)
    model.split('_').map{ |word| word.capitalize }.join(' ')
  end

  private
  def not_table
    [
        'WiceGridSerializedQuery',
        'ActiveRecord::SchemaMigration',
        'ApplicationRecord'
    ]
  end
end
