class Admin::ModelController < Admin::BaseController

  before_action :get_object_model

  def index
    @visible_columns = visible_columns @model
    @index = @model.all
  end

  def show
    @visible_columns = visible_columns @model
    @row = @model.find(params[:id])
  end

  def edit
    @row = @model.find(params[:id])
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

  def get_object_model
    @model = Kernel.const_get(name_model params[:model])
  end

  def visible_columns(model)
    return model.column_names unless defined? model::VISIBLE_COLUMNS
    model::VISIBLE_COLUMNS
  end

end
