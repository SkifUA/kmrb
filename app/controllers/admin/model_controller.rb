class Admin::ModelController < Admin::BaseController

  def index
    @model = object_model params[:model]
    @visible_columns = visible_columns @model
    @index = @model.all
  end

  def show
    @model = object_model params[:model]
    @visible_columns = visible_columns @model
    @row = @model.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def name_model(param)
    param
        .singularize
        .camelize
  end

  def object_model(param)
    @model = Kernel.const_get(name_model param)
  end


  def visible_columns(model)
    return model.column_names unless defined? model::VISIBLE_COLUMNS
    model::VISIBLE_COLUMNS
  end
end
