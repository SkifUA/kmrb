module Admin::ModelHelper
  def show_data_column(row, column)
    if column =~ /_id$/
      object = column.sub(/_id$/, '')
      return row.send(object).name if defined? row.send(object).name
    end
    row.send(column)
  end

  def show_label_column(column)
    if column =~ /_id$/
      object = column.sub(/_id$/, '')
      return object if defined? Kernel.const_get(object.camelize).name
    end
    column
  end
end
